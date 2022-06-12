Question 1: How many users do we have?

    select count(distinct user_id) as users_count
    from dbt.dbt_katelyn_m.stg_greenery__users ;

**Answer: 130 users**


Question 2: On average, how many orders do we receive per hour?

    with orders_per_hour as (
        select date_trunc('hour',created_at_utc) as created_at_hour,
            count(order_id) as order_count
        from dbt.dbt_katelyn_m.stg_greenery__orders
        group by 1
    )
    
    select round(avg(order_count), 2) as avg_order_count_per_hour from orders_per_hour ;

**Answer: On average, we receive 7.52 orders per hour**


Question 3: On average, how long does an order take from being placed to being delivered?

    select sum(delivered_at_utc - created_at_utc)/count(order_id) as average_time_to_delivery
    from dbt.dbt_katelyn_m.stg_greenery__orders
    where order_status = 'delivered' ;

**Answer: On average it takes 3 days, 21 hours 24 minutes and 11.8 seconds from the time an order is place to when it is delivered**


Question 4: How many users have only made one purchase? Two purchases? Three+ purchases?

    select user_id,
        count(user_id) as user_count
    from dbt.dbt_katelyn_m.stg_greenery__orders
    group by 1
    having count(user_id) = 1 ;

    select user_id,
        count(user_id) as user_count
    from dbt.dbt_katelyn_m.stg_greenery__orders
    group by 1
    having count(user_id) = 2 ;

    select user_id,
        count(user_id) as user_count
    from dbt.dbt_katelyn_m.stg_greenery__orders
    group by 1
    having count(user_id) >= 3 ;

**Answer: 25 users have only made one purchase, 28 users have made two purchases, and 71 users have made three+ purchases**


Question 5 : On average, how many unique sessions do we have per hour?

    with sessions_per_hour as (
        select date_trunc('hour',created_at_utc) as created_at_hour,
            count(distinct session_id) as distinct_session_count
        from dbt.dbt_katelyn_m.stg_greenery__events
        group by 1
    )
 
    select round(avg(distinct_session_count), 2) as avg_distinct_session_count_per_hour
    from sessions_per_hour ;

**Answer: On average, there are 16.33 unique sesions per hour**