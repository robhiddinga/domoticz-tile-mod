commandArray = {}

--As text tiles are limited in their presentations options
--I decided next best would be to modify a custom sensor
--As examples are scarce I share my snippet

DOMO_IP           = "192.168.x.x"
DOMO_PORT         = "8080"
afvaldevice_id    = 874
--Replace above by your own settings

afvalstroom       = {'een', 'Grijs','Papier','vier','Groen','Plastic'}
afvalstroom_icons = {'0', '131','132','133','134','0'}
--replace the numbers by the numbers of your own custom icons (they start at 100)
devicename_1      = 'Volgende%20afval%20is%20'
--device name can not contain space, so using %20 (which is space)

description       = '10 jun groen * 11 jun grijs * 12 juni gft'
firstday          = '10'
firstmonth        = 'jun'
afvalstroom_id    = 3
afvalstroom_icon  = afvalstroom_icons[afvalstroom_id]
devicename        = devicename_1..'%20'..afvalstroom[afvalstroom_id]

--description does not accept blanks when pushed over json
description       = description.gsub(description, " ", "_")

--Changing all at once with json did not seem to work,so:
--First only change the svalue (in this case daynumber)
oscall = os.execute('curl -s -i -H "Accept: application/json" "http://"'..DOMO_IP..'":"'..DOMO_PORT..'"/json.htm?type=command&param=udevice&idx="'..afvaldevice_id..'"&svalue="'..firstday)
print(oscall)

--Now change icon,name, description and devoptions (month)
oscall = os.execute('curl -s -i -H "Accept: application/json" "http://"'..DOMO_IP..'":"'..DOMO_PORT..'"/json.htm?type=setused&idx="'..afvaldevice_id..'"&switchtype=General&used=true&description="'..description..'"&name="'..devicename..'"&customimage="'..afvalstroom_icon..'"&devoptions=1;"'..firstmonth)
print(oscall)

return commandArray
