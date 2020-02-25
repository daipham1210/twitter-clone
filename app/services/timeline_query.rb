class TimelineQuery
  class <<self
    def call(page, per_page: 10)
      Micropost.find_by_sql(
        [
          sql_statement,
          {
            limit: per_page,
            offset: offset(page, per_page)
          }
        ]
      )
    end

    def sql_statement
      %(
        SELECT tweets.id, tweeter.username AS username, content, tweets.created_at,
               retweet_number, parent_id, parent_user_id,
               parent_tweeter.username AS parent_username, parent_content
        FROM
        (
          SELECT t.id, t.user_id, t.content, t.created_at, t.retweet_number,
                NULL AS parent_id, NULL AS parent_user_id, NULL AS parent_content
          FROM microposts as t
          UNION ALL
          (SELECT rt.id, rt.user_id, rt.content, rt.created_at, t.retweet_number,
                t.id AS parent_id, t.user_id AS parent_user_id, t.content AS parent_content
          FROM retweetings as rt
          INNER JOIN microposts as t ON rt.micropost_id = t.id)
        ) as tweets
        INNER JOIN users AS tweeter ON tweets.user_id = tweeter.id
        LEFT JOIN users AS parent_tweeter ON tweets.parent_user_id = parent_tweeter.id
        ORDER BY retweet_number DESC
        LIMIT :limit OFFSET :offset
      )
    end

    def offset(page, per_page)
      (page - 1) * per_page
    end
  end
end
