


with open('bing.com_recon/live-sub.txt', 'r') as file:
    lines = file.readlines()


url_dict = {}


for line in lines:
    url, number_str = line.strip().rsplit('[', 1)
    number = int(number_str[:-1])  

    
    if number not in url_dict:
        url_dict[number] = url


for number, url in url_dict.items():
    #print(f"{url} [{number}]")
    url = url.strip()
    print(f"{url}")