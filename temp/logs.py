# Open the text file
with open('enrich.txt', 'r') as file:
    # Read each line
    for line in file:
        # Check if the line contains the required information
        if 'total time' in line:
            total_time = int(float(line.split('=')[1].strip().split(' ')[0].strip()) // 1000)
            # Print the total time
            print(f'{total_time}')
