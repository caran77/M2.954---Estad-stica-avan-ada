begin
    re_pk_pase.drop_tab('temp');
end;
/    

create table temp (
    ttoo    number(8),
    dia     date,
    cancel_1_hour varchar2(1),
    cancel_24_hour varchar2(1)
);

declare 
    cursor c_sel is
        select *
        from    re_t_re_reserva
        where   fec_creacion between to_date('01/04/2019', 'dd/mm/rrrr') and to_date('07/04/2019 23:59:59', 'dd/mm/rrrr hh24:mi:ss');
    type t_sel is table of c_sel%rowtype;
    v_sel t_sel;   
    v_can_1_hour varchar2(1) := 'N';     
    v_can_24_hour varchar2(1) := 'N';    
begin
open c_sel;
    loop
        fetch c_sel bulk collect into v_sel limit 1000;
        for i in 1..v_sel.count loop
            v_can_1_hour := 'N';
            if v_sel(i).fec_cancelacion - v_sel(i).fec_creacion <= 1/24 then
                v_can_1_hour := 'S';
            end if;
            v_can_24_hour := 'N';
            if v_sel(i).fec_cancelacion - v_sel(i).fec_creacion <= 1 then
                v_can_24_hour := 'S';
            end if;            
            insert into temp(
                ttoo, 
                dia,
                cancel_1_hour,
                cancel_24_hour
            ) values (
                v_sel(i).gtto_seq_ttoo, 
                trunc(v_sel(i).fec_creacion),
                v_can_1_hour,
                v_can_24_hour
            );
        end loop;
        commit;
        exit when c_sel%notfound;
    end loop;
    close c_sel;
end;        

select ttoo, sum(decode(to_char(dia, 'D'), 1, 1, 0)) created_sunday, 
          sum(decode(to_char(dia, 'D')||cancel_1_hour, '1S', 1, 0)) created_sunday_cancel_1_hour,
           sum(decode(to_char(dia, 'D')||cancel_24_hour, '1S', 1, 0)) created_sunday_cancel_24_hour,
          sum(decode(to_char(dia, 'D'), 2, 1, 0)) created_monday, 
          sum(decode(to_char(dia, 'D')||cancel_1_hour, '2S', 1, 0)) created_monday_cancel_1_hour,
           sum(decode(to_char(dia, 'D')||cancel_24_hour, '2S', 1, 0)) created_monday_cancel_24_hour, 
          sum(decode(to_char(dia, 'D'), 3, 1, 0)) created_tuesday, 
          sum(decode(to_char(dia, 'D')||cancel_1_hour, '3S', 1, 0)) created_tueday_cancel_1_hour,
           sum(decode(to_char(dia, 'D')||cancel_24_hour, '3S', 1, 0)) created_tusday_cancel_24_hour,
          sum(decode(to_char(dia, 'D'), 4, 1, 0)) created_wednesday, 
          sum(decode(to_char(dia, 'D')||cancel_1_hour, '4S', 1, 0)) created_wednes_cancel_1_hour,
           sum(decode(to_char(dia, 'D')||cancel_24_hour, '4S', 1, 0)) created_wednes_cancel_24_hour,
          sum(decode(to_char(dia, 'D'), 5, 1, 0)) created_thursday, 
          sum(decode(to_char(dia, 'D')||cancel_1_hour, '5S', 1, 0)) created_thursday_cancel_1_hour,
           sum(decode(to_char(dia, 'D')||cancel_24_hour, '5S', 1, 0)) created_thurs_cancel_24_hour,
          sum(decode(to_char(dia, 'D'), 6, 1, 0)) created_friday, 
          sum(decode(to_char(dia, 'D')||cancel_1_hour, '6S', 1, 0)) created_friday_cancel_1_hour,
           sum(decode(to_char(dia, 'D')||cancel_24_hour, '6S', 1, 0)) created_friday_cancel_24_hour,
          sum(decode(to_char(dia, 'D'), 7, 1, 0)) created_saturday, 
          sum(decode(to_char(dia, 'D')||cancel_1_hour, '7S', 1, 0)) created_saturday_cancel_1_hour,
           sum(decode(to_char(dia, 'D')||cancel_24_hour, '7S', 1, 0)) created_satur_cancel_24_hour                                                  
from temp 
group by ttoo 
having sum(decode(to_char(dia, 'D'), 1, 1, 0)) = 1507

select *
from temp
where created_sunday = 1507

select *
from re_t_ge_ttoo 
where seq_ttoo = 30542

select  ttoo,

select count(*)
from    re_t_re_reserva
where fec_creacion between to_date('06/04/2019', 'dd/mm/rrrr') and to_date('06/04/2019 23:59:59', 'dd/mm/rrrr hh24:mi:ss' ) 
 and    fec_cancelacion - fec_creacion < 1