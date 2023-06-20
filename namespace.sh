# name assing inside variables
nameSpace1="red"
nameSpace2="blue"
vEth1="veth-red"
vEth2="veth-blue"
ipAddr1="10.0.0.1/24"
ipAddr2="10.0.0.2/24"
ip1="10.0.0.1"
ip2="10.0.0.2"

# for adding namespaces 
ip netns add $nameSpace1
ip netns add $nameSpace2

# creating a veth cable for the network connection
ip link add $vEth1 type veth peer name $vEth2

# veth part are connected to the two namespaces
ip link set $vEth1 netns $nameSpace1
ip link set $vEth2 netns $nameSpace2

# adding namespaces adderesses
ip -n $nameSpace1 addr add $ipAddr1 dev $vEth1
ip -n $nameSpace2 addr add $ipAddr2 dev $vEth2

# active the veth cable
ip -n $nameSpace1 link set $vEth1 up
ip -n $nameSpace2 link set $vEth2 up

# # 
# ip netns exec $nameSpace1 ip route add default via $ip1 dev $vEth1
# ip netns exec $nameSpace2 ip route add default via $ip2 dev $vEth2

#  cheak the ping if working
ip netns exec $nameSpace1 ping $ip2 

# for delated the two namespaces
ip netns delete $nameSpace1
ip netns delete $nameSpace2