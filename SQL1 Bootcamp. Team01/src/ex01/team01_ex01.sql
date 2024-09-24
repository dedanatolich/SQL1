WITH new_balance AS (
	SELECT b.user_id AS user_id, b.money AS money, b.updated AS updated,
		c.name AS cur_name, c.rate_to_usd AS cur_rate, c.updated AS cur_updated
	FROM balance b
	JOIN currency c ON b.currency_id = c.id
),
total_currency AS (
	SELECT max_upd.id, max_upd.cur_name, max_upd.money, max_upd.updated,
		COALESCE(min_upd.diff,max_upd.diff) new_diff
	FROM (
		SELECT nb.user_id AS id, cur_name, money, updated,
			MIN(updated - cur_updated) AS diff
		FROM new_balance nb
		WHERE updated - cur_updated > INTERVAL '0 days'
		GROUP BY 1, 2, 3, 4
	) min_upd
	FULL JOIN (
		SELECT nb.user_id AS id, cur_name, money, updated,
			MAX(updated - cur_updated) AS diff
		FROM new_balance nb
		WHERE updated - cur_updated < INTERVAL '0 days'
		GROUP BY 1, 2, 3, 4
	) max_upd
	ON min_upd.id = max_upd.id AND min_upd.cur_name =max_upd.cur_name
		AND min_upd.money =max_upd.money AND min_upd.updated =max_upd.updated
)

SELECT COALESCE(u.name, 'not defined') AS name,
	COALESCE(u.lastname, 'not defined') AS lastname,
	tc.cur_name AS currency_name,
	tc.money * currency.rate_to_usd AS currency_in_usd
FROM total_currency tc
LEFT JOIN "user" u
ON tc.id = u.id
LEFT JOIN currency
ON tc.new_diff = (tc.updated - currency.updated) AND tc.cur_name = currency.name
ORDER BY 1 DESC, 2 ASC, 3 ASC;