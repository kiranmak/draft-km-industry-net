---
abbrev: industrial-network-req
docname: draft-km-industrial-internet-requirements-00
title: Requirements and Scenarios for Industry Internet Addressing 
date:  false
category: info

ipr: trust200902
area: INTAREA
workgroup: Independent Submission
keyword: Internet-Draft

stand_alone: yes
pi: [toc, sortrefs, symrefs]

author:
-
  ins: K. Makhijani
  name: Kiran Makhijani
  org: Futurewei
  email: kiran.ietf@gmail.com
-
  ins: L. Dong
  name: Lijun Dong
  org: Futurewei
  street: Central Expy
  city: Santa Clara, CA 95050
  country: United States of America
  email: lijun.dong@futurewei.com

informative:

  LDN: RFC8799
  DETNET-DP: RFC8939
  DETNET-ARCH: RFC8655
  SCHC: RFC8724
  ROHC: RFC4995
  FlexIP: I-D.moskowitz-flexip-addressing
  Flexible_IP: I-D.jia-flex-ip-address-structure
  CHALLEN: I-D.jia-intarea-scenarios-problems-addressing
  SOIP: I-D.service-oriented-ip
  FHE:  I-D.jiang-asymmetric-ipv6

  IEEE802.1TSNTG:
    target: https://1.ieee802.org/tsn
    title: IEEE, "Time-Sensitive Networking (TSN) Task Group"
    date: 2018
  
  SURV: 
    DOI.10.1109/SURV.2012.071812.00124

--- abstract

Industry Control Networks host a diverse set of non-internet protocols for different purposes. Even though they operate in a controlled environment, one end of industrial control applications run over internet technologies (IT) and another over operational technology (OT) protocols.  This memo  discusses the challenges and requirements relating to converegence of OT and IT networks. 
 One particular problem in convergence is figuring out reachability between the these networks.

--- middle

# Introduction {#intro}

An industry control network interconnects devices used to operate, control and monitor  physical equipment in industrial environments. These networks are increasingly becoming complex as the emphasis on convergence of OT/IT grows to improve the automation. On one side of Industrial internet are the inventory management, supply chain and simulation software and the other side are the control devices operating on machines. Operational Technologies (OT) networks are more often tied to set of non-internet protocols such as 
Modbus, Profibus, CANbus, Profinet, etc. There are more than 100 different protocols each with it's own packet format and are used  in the industry. 


It is expected that integration between the IT and OT will provide numerous benefits in terms of improved productivity, efficiency of operations by providing end to end visibility and control. Industry control applications also expect to operate at cloud scale by virtualization of several modules (especially PLCs) leading to new set of network requirements.

One aspect of industry control is the delivery of data associated with the Real-time, deterministic and reliability characteristics over local-area and wide-area networks. This type of inter-operability functionality and study is already covered in DETNET working group. The other aspect is rachability and interconnection keeping heterogenity of communication interfaces and a variety of services in mind. This doument focuses on the latter part only. 

OT networks have been traditionally separate from the IT networks. It allowed OT network experts to manage and control proceses without much dependency on changes in the external networks. This is an important to consideration when dealing with the industry control networks to maintain them in a controlled environment leveraging the limited-domain networks {{LDN}} concept for an independent network control.

The purpose of this document is to discuss the reachability and interconnection characteristics, challenges and new requirements emerging from large-scale integration of IT and OT.


# Terminology

* Industrial Control Networks:
The indutrial control networks are interconnection of equipments used for the operation, control or monitoring of machines in the industry environment. It involves different level of communications - between fieldbus devices, digital controllers and software applications

* Industry Automation: Mechansims that enable  machine to machine communication by use of technologies that enable automatic control and operation of industrial devices and  processes leading to minimizing human intervention.

* Human Machine Interface: An interface between the operator and the machine. The communication interface relays I/O data back and forth between an oeprator's terminal anf HMI software to control and monitor equipment.

{::comment}
* Machine  Machine Interface (MMI): This term is newly introduced for the scope of this document to describe an interface between the operator terminal software and the machine or from an auomation engine to the device. This interface takes HMI out of the loop, by automating control and monitoring functions through software.
{:/comment}


## Acronymns
* HMI: Human Machine Interface



# Industrial Network Reference Architecture {#arch}

In the scope of this document the following reference  industrial network will be used to provide structure to the discussion. In the Fig. {{indusarch}} below, a hierarchy of communications is shown. At the lowest level, PLCs operate and control field devices; above that Human Machine Interface
 (HMI) interconnects with different PLCs to program and control underlying field devices. HMI itself, sends data up to applications for consumption in that industry vertical.


          +-+-+-+-+-+-+
       ^  | Data Apps |....             External business logic network
       :  +-+-+-+-+-+-+   :
       :        |         : 
       v  +-+-+-+-+-+-+  +-+-+-+-+--+
          | vendor A  |  |vendor B  |     Interconnection of 
          | controller|  |controller|     controllers (system integrators)
       ^  +-+-+-+-+-+-+  +-+-+-+-+-+    
       :       |         |          
       :   +-+-+-+-+  +-+-++-+
       :   | Net X |  | Net Y|
       v   | PLCs  |  | PLCs |--+        device-controllers
       ^   +-+-+-+-+  +-+-+--+  |
       :      |        |        |
       :   +-+-+    +-+-+    +-+-+
       v   |   |    |   |    |   |   Field level devices 
           +-+-+    +-+-+    +-+-+
{: #indusarch title="Hierarchy of Functions Industrial Control Networks"}


Unlike commercial networks that uniformly run IP protocols, the communication links run different protocols at along the different level of the hierarchy. One of the key requirement from new industrial applications is the integration of different types of communication protocols including Modbus, Profinet, Profibus, ControlNet, CANOpen etc.  

A vertically integration system involves a network between the external business applications and higher controllers (for e.g. SCADA, HMI, or system integrators) is IP based. The second level of networks between  the controllers can be either IP or non-IP (Profibus, BACNet, etc.). The lowest field-level networks between industrial controllers and field-level may be any of the fieldbus or device control protocols (More details of the industry networks can be found in  {{SURV}}).

## Communication Patterns

The following communication patterns are commonly observed:

- controller to controller: A communication between multi-vendor controller maybe required by system integrators to work in complex systems.

- controller to field level devices:  This is a fieldbus communication between device such as I/O modules, motors, controllers. This communication represent.

- Device to device: allows direct communication between wired industrial devices and wireless devices to enhance automation use cases. For an exmaple, use of camera to visually monitor and detect anamolies in other devices.

- controller to compute: vertical communication between a controller and compute integrates IP-based technologies with non-IP since OT product systems and solutions are not connected with IP based networks.

A certain level of inter-operability is required to exchange data between the above endpoints from different vendors. One of the challange is that Ethernet (which unifies IT standards) that's not always possible in Industry networks.


## Industry Control Network Nuances (current state)

The Industry control networks are engineered for the idustry verticals they belong to and depict unique properties as below:

{::comment}
Even with the increase in sensors and control devices, the industry networks (factory floors, manufacturing plants, power-grid, etc.) remain a closed and well-engineered networks. As a result,
   traditinal means of scaling up the infrastructure are not straight forward.
{:/comment}

   * location bound:  The Control Device's location or the network they are
   attached to is predetermined and changes rarely. However, the network resources may 
   not get efficiently utilized to avoid contention between them.

   * security by separation: Typically, security is enhanced by keeping IT/OTnetworks separate. The 
     operators control how data  goes in and out of a site through firewalls and policies.

   * data growth: Even though the size of network remains the same, data generated is much higher. For example, cameras installed for visual inspection to determine the quality of manufactured product generates a high bandwidth demand.

   * Wired device constraints: A bulk of machines are over wired network, their constraints vary from LPWAN  and IoT devices which is an active area of standardization work. device lifetime, or power-requirements are  not typical constraints. Instead direct process control mechanisms are more important.

   * Real-time behavior: The control devices require realtime as well as deterministic behavior between a controller (such as an HMI station) to the equipment. The DetNet working group covers several aspects.

  The goal of the document is not to reinvent the Industry control infrastructure. See section {{relevance}} on related standards work. It is meant to exclude the already covered by other WGs.

  Since a device connects to network through its address, the document explores different address specific nuances in control devies - such as management, device discovery and integration requirements. This document concerns with the identification of and role networks, specifically from the organization of industry control devices. 


   The goal of this document is to outline some of the challenges and improvement of connectivity aspects of Industry control networks.  
  

# Problem Statement {#problem}

In industrial networks, a good number of devices still communicate over a serial or field bus (although Ethernet is being gradually adopted). The operations on these devices are performed by writing provide direct access to operation-control. i.e what operation to perform is embedded in the type of interface itself. For instance, Profibus, Modbus networks are implicitly latency sensitive and short control-command based.

~~~~~
  ModBus
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   | address | Function  code  | data|
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

  CANBus

   +-+-+-+-+-+-+-+-+-+-+--+-+-+
   |   message id  |    data  |
   +-+-+-+-+-+-+-+-+-+-+-++-+-+
   Profibus - todo.
~~~~~

Since they are localized in an area such as factory floor or a site, such networks have evolved independently and are seperated from the IT applications. The emerging trend requires a seamless integration with intelligent software, sophisticated compute platforms and other operational aspects as highlighted below:

## Heterogenity

A typical industry control network has devices of different communication interfaces such as Fieldbus (PROFIBUS, Modbus, and HART), Ethernet (generic Ethernet/IP, PROFINET, and Modbus-TCP), and also wireless (Bluetooth, Wireless HART, and IoT). These interfaces vary at the physical and link layers and because they integrate with their own application technologies providing interoperability between these devices remains a challenge. This also makes difficult to adopt to modern integration technologies. 

Fieldbus client-server architecture is widely deployed. It delivers commands  deterministically from a controller to the device and vice-a-versa. Interfaces of this kind have typically shorter addresses (upto 256 devices on a single bus in Modbus).

Some of the servers also behave as protocol gateways and interconnect different type of protocols. For example when a modbus device is being controlled by a profinet server, an gateway function will translate modbus data or encapsulate it over IP (if the controller supports it).


 In a Gateway-centric approach, gateways are in charge of protocol translations between the devices with different interfaces. This requires packing and unpacking of data in the source and destination formats at the attached gateways. 
 Note: As an example, a Modbus device does not know whether to send command to Profibus PLC or Modbus PLC. The gateway device attaches to performs the translation. This is even worse with encapsulations, where the entire frame is carried over IP.

 This is not ideal for latency sensitive applications. Although hardware wise, gateways need to be equipped with all the interface, it is more efficient to only perform data link conversion.

  {::comment}
 LJ}: here we need to explain why gateway-based approach is not
   ideal.  Gateway based approach requires the gateway which is in
   charge of translation between devices with different interfaces to be
   equipped with both interfaces.  For example, a gateway residing in a
   modbus network which is able to unpack a packet sent from a profinet
   server and pack it to a modbus compatible packet needs to have both
   the modbus and profibus interfaces and addresses.  If IP is used
   between profibus gateway and modbus gateway, dual stacks of profibus/
   IP and modbus/IP are in place in such gateways.  The destination
   address and commands are encapsulated in the packet data.  It
   involves several rounds of packing and unpacking process at the
   source gateway and destiantion gateway.  The source gateway needs to
   carry out the unpacking process to extract the destination address
   from the packet data.  Then based on the destination address, it
   needs to figure out the destination gateway's IP address, then pack
   the packet again with the approriate source and destiantion IP
   addresses.  When the packet arrives at the destination gateway, the
   same unpacking and packing process would be carried out again.  Such
   gateway-based approach prolongs the processing delay for packet
  {:/comment}


## Automation Impact
Automation of processes in industry relies on control sophisticated technologies such as machine learning, big data, etc. with minimal human intervention. Automation  needs to support scale, reliability and resiliance at large-scale.

### Scale

 Automation control at small scale applications with well defined task has been possible. In order to improve production, and eliminate stoppages and minimizing human intervention.

 When the number or density of devices, and processes increase there is a need to schedule, route, and  coordinate over multiple control environments. 

### Stretch Control Fabric to Edge and Cloud

 The industry control networks can be extended to cloud or edge compute platforms. Since these networks are not equipped with compute intensive servers. Now extending the communication to the edge and cloud nodes increases the distance requiring traditional L2 networks to be adopted to L3 network designs. 

 Design decisions will require to choose different transit strategies (this maybe layer 1, 2, 3 technologies or even network slices). It also influence the security policies.

### Reliability
Production efficiency is inversely related to number of defects in a process. System reliability is determined through measurements of its instantaneous state. 

Automation processes  need to ensure that system is performing in an expected state and is capable of reporting anamolies fast and accurately (i.e. packet drops or jitter leading to poor quality product).

### Resilience

TBD.

## OT/IT Convergence 
Most of the factory floors are not equipped with IT servers to perform compute intensive tasks. Yet an IP-based device need to connect with non-IP interface to control those devices.

Often real-time response is necessary for example, in closed-loop control systems direct communication is desired to avoid any additional packet processing delay or overheades at the source and destination gateways, equipping IP to all OT devices and abandoning the existing investment and depolyment could result in the following obvious problems.

{::comment}
{LJ}: again, gateway-based approach could solve this problem. So the following observations are reasonable, however, do not address why gateway-based approach is not preferable. Maybe add:  

If direct communication is desired to avoid extra processing delay at the source and destination gateways, equipping IP to all OT devices and abandoning the existing investment and depolyment could result in the following obvious problems: {LJ}
{:/comment}


  * Many of the standard IP based protocols maybe too much overhead for OT devices.
  * Cannot preserve communication characteristics of devices (different device addressing scheme, realtime, IRT, message identifiers, Bus-like properties).
  * It relies heavily on hierarchy network stack (network layer, transport layer, application), where as OT devices do not have any, they generally operate at data link layer or below.


## Data oriented networking
Industry verticals keep data and control on the manufacturing floor, on a closed system. There is no easy way to forward this data to enterprise level software. On premise micro data centers or edge computing are new infrastructure pieces that wil impact the design of current industrial networks. 

## Virtualization
Traditional Industry control infrastructure is not virtualized. Virtualization will enable deployment of new functionality in a flexible manner.  

- Virtual PLCs are considered an important component functionality customization of digital-twin realization.
- virtualization enables edge and cloud native computing by moving and instantiating workflows at different locations.

Implications that PLCs are no longer one-hop away.


# Address Space Requirements {#reqs}

## Short Device Addressing
Shorter addresses are inherent to industry control systems to provide implicit determinism.

Note: The motivation for short address is to preseve the legacy attributes of fieldbus control devices. It is not related low-power or resource constraints.

A large volume of the messages are of sizes shorter than the size of IP headers (v4, v6) themselves. The header tax will be very high over industry control networks.

## Meaningful Addresses

The industry control floors are built bottom-up. The devices are carefully wired and connected to controllers. In a hierarchical network design, a particular type of machine can be reached in a structured manner by adding subnet or location to the address structures.

## Device name based  Addresses
HMI might require human readable address that is  undertandable to human operators or application end users. For example, a device address could be associated with its location, type of applications, attached objects etc. The network needs to support the resolution and routing based on such device addresses, which is more user friendly. On the other hand, grouping devices based on their addresses shall be easily implemented to enable group operation and communication.


## Adoption of Lean Network Layer 
Challenge of Industrial network device address is that it  communicates to a physical device address. Traditionally, in a limited environment there was no need for network layer or expressing network specific service, access control.

- If a sensor is broken, it will require reprogramming of controller and re-aligning with the new address. The benefit of network layer, removes this restriction. 
- Note that, using IP stack is not suitable because these devices perform specific functions and any overhead in transport or large addressing can add to processing delays.
- Several other IP suite protocols such as device discovery should be revisited.


## Multi-semantic behavior
OT networks, at least at site level are organized at much smaller scale than typical IP-capable networks. There is in turn a fixed hierarchy of networks w.r.t. location in a plant.

## Interoperability with IP-world machines

To develop further on different type of address format support. From smaller address of legacy devices to IT based applications with IP address.

~~~~~
(OT-Address )--->(Industry Control)--->(IP-Address) 
(control dev)    (   network      )    (application)
~~~~~

Preferably allow OT devices to understand IP-addresses for the servers they connect to.


# Relationship with  Activities in IETF {#relevance}

## Deterministic Networks (DetNet WG)
The Deterministic Networking (DetNet) {{DETNET-ARCH}} is working on using IP for long-range connectivity with  bounded latency in industry control networks . Its data plane {{DETNET-DP}} takes care of forwarding aspects and most close to Industry control networks but the focus is on the controlled latency, low packet loss & delay variation, and high reliability functions. Not dealing with interconnection of devices.

In layer 2 domain, similar functionalty is convered by TSN Ethernet {{IEEE802.1TSNTG}}.

## IoT OPS
IoT operations group discusses device security, privacy, and bootstrapping and device onboarding concepts. Among the device provisioning one of the object is network identifier. We understand that the IoT OPs does not exclude evaluation of industry IoT or control devices requirements.
Given the specific functions described above it maybe necessary to configure more than an identifier, i.e. server or controller information or specific address scope and structure.


## LPWAN
The LPWAN has focussed on low-power and constrained devices. There are compression related approaches that may apply are {{SCHC}} or {{ROHC}}.
To be evaluated for process control devices.

## Recent Addressing related work

Some of the work initiated on the addressing include solutions
such as {{FlexIP}}, {{Flexible_IP}}, {{FHE}}, and {{SOIP}}.
 
Recently, a broader area of problem statement and challenges in {{CHALLEN}}.


 

#IANA Considerations

This document requires no actions from IANA.

#Security Considerations

This document introduces no new security issues.

#Acknowledgements


--- back

