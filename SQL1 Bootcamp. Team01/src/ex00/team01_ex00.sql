WITH last_rate AS (
	SELECT id, rate_to_usd,
		ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated DESC) AS rank
	FROM currency
),
each_balance_sum AS (
	SELECT user_id, SUM(money) AS total, type AS balance_type, currency_id
	FROM balance
	GROUP BY user_id, type, currency_id
)

SELECT COALESCE(u.name, 'Not defined') AS name,
	COALESCE(u.lastname, 'Not defined') AS last_name, b.type AS type,
	ebs.total AS volume, COALESCE(c.name, 'Not defined') AS currency_name,
	COALESCE(lr.rate_to_usd, 1) AS last_rate_to_usd,
	ebs.total * COALESCE(lr.rate_to_usd, 1) AS total_volume_in_usd
FROM balance b
LEFT JOIN "user" u ON b.user_id = u.id
LEFT JOIN each_balance_sum ebs ON b.user_id = ebs.user_id
	AND b.type = ebs.balance_type AND b.currency_id = ebs.currency_id
LEFT JOIN currency c ON b.currency_id = c.id
LEFT JOIN last_rate lr ON b.currency_id = lr.id AND lr.rank = 1
GROUP BY u.name, u.lastname, b.type, c.name, lr.rate_to_usd, ebs.total
ORDER BY name DESC, last_name, b.type, c.name;