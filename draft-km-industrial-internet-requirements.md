---
abbrev: indnetwork 
docname: draft-km-industrial-internet-requirements-latest
title: Requirements and Scenarios for Industry Internet Addressing 
date: 2021-05-25
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
    org: Futurewei Technologies, Inc.
    street: Central Expy
    city: Santa Clara, CA 95050
    country: United States of America
    email: kiran.ietf@gmail.com

informative:

  LDN: RFC8799
  DETNET-DP: RFC8939
  DETNET-ARCH: RFC8655

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

An industrial control network interconnects devices used to monitor and control physical equipment in industrial environments. These networks are increasingly becoming complex as the emphasis on convergence of OT/IT grows. Operational Technologies (OT) networks are more often tied to set of non-internet protocols such as 
Modbus, Profibus, CANbus, Profinet, etc. There are more than 100 different protocols each with it's own packet format and are in use by a majority of devices in industry control networks use. 
There is a growing demand to integrate IT-centric applications to improve the automation in industry networks. One one side of Industrial internet are the inventory management, supply chain and simulation software and the other side are the control devices operating on machines.

It is expected that integration between the IT and OT will provide numerous benefits in terms of improved productivity, efficiency of operations by providing end to end visibility and control.

{::comment}

Most industrial operations have custom built application, management software suitable for their own vertical domain.  
{:/comment}

A key property of the industry control network is their own private environment and are operating in limited-domain {{LDN}}. So far, IT and OT networks have evovled seperately, but now to integrate with emerging IT applications and services, for Machine-type communications, the protocols should provide means to integrate with  IIoT.

# Terminology
* Industrial Control Networks:
The indutrial control networks are interconnection of equipments used for the operation, control or monitoring of machines in the industry environment. It involves different level of communications - between fieldbus devices, digital controllers and software applications
* Industrial Networking
Involves communication
* Industry Automation
* Human Machine Interface: An interface between the operator and the machine. The communication interface relays I/O data back and forth between an oeprator's terminal anf HMI software to control and monitor equipment.

{::comment}
* Machine  Machine Interface (MMI): This term is newly introduced for the scope of this document to describe an interface between the operator terminal software and the machine or from an auomation engine to the device. This interface takes HMI out of the loop, by automating control and monitoring functions through software.
{:/comment}


## Acronymns
* HMI: Human Machine Interface



# Industrial Network Reference Architecture {#arch}

For the scope of this document the following reference  network will be used to provide some structure to discussion. In the Fig. {{indusarch}} below, a hierarchy of communications is shown. At the lowest level, PLCs operate and control field devices; above that Human Machine Interface
 (HMI) interconnects with different PLCs to program and control underlying field devices. HMI itself, sends data up to applications for consumption in that industry vertical.


          +-+-+-+-+-+-+
       ^  | Data Apps |....             External business logic network
       :  +-+-+-+-+-+-+   :
       :        |         : 
       v    +-+-+-+    +-+-+-+
            | HMI | |automation|        Interconnection of controllers
       ^    +-+-+-+    +-+-+-+    
       :       |         |          
       :   +-+-+-+   +-+-+-+
       v   | PLCs |  | PLCs|----+       industrial controller network
       ^   +-+-+-+   +-+-+-+    |
       :      |        |        |
       :   +-+-+-+   +-+-+-+   +-+-+-+
       v   |     |   |     |   |     |  Field devices/equipment 
           +-+-+-+.  +-+-+-+   +-+-+-+
{: #indusarch title="Hierarchy of Functions Industrial Control Networks"}


Unlike commercial networks that uniformly run IP protocols, the communication links run different protocols at each level of the hierarchy. Industry control networks are of type LDN, the operators need flexibility to integrate different types of communication protocols including Modbus, Profinet, Profibus, etc. that may have been standardized outside the IETF protocol suite. The general trend is:
* network between the external business applications and HMI (or MMI) is IP based. It may include both on-prem or cloud-based networking.
* network between HMI to industrial controllers can be either IP or non-IP (Profibus, BACNet, etc.).
* network between industrial controllers and fieldbus may be any of the fieldbus or device control protocols.

More details of state of the art are in {{SURV}}.

## Industry Control Network Nuances (current state)

The Industry control networks are engineered for the idustry verticals they belong to.
 This integration, Industry Control Networks provide numerous benefits for control networks: just-in-time manufacturing, better efficiency, and improved visibility and management of the Control Devices (CDs). Even with the increase in sensors and control devices, the industry networks (factory floors, manufacturing plants, power-grid, etc.) remain a closed and well-engineered networks. As a result,
   traditinal means of scaling up the infrastructure are not straight forward.

   * location bound:  The Control Device's location or the network they are
   attached to is predetermined and changes rarely. However, the network resources may 
   not get efficiently utilized to avoid contention between them.

   * security by separation: Typically, security is enhanced by keeping IT/OTnetworks separate. The 
     operators control how data  goes in and out of a site through firewalls and policies.

   * data growth: Even though the size of network remains the same, data generated is much higher. For example, cameras installed for visual inspection to determine the quality of manufactured product generates a high bandwidth demand.

   * Wired device constraints: A bulk of machines are over wired network, their constraints vary from LPWAN  and IoT devices which is an active area of standardization work. device lifetime, or power-requirements are  not typical constraints. Instead direct process control mechanisms are more important.

   * Real-time behavior: The control devices require realtime behavior between an HMI station to the equipment. This is different from LPWANs but DetNet covers several asp

  The goal of the document is not to reinvent the Industry control infrastructure. See section {{relevance}} on related standards work. It is meant to exclude the already covered by other WGs.

  Since a device connects to network through its address, the document explores different address specific nuances in control devies - such as management, device discovery and integration requirements. This document concerns with the identification of and role networks, specifically from the organization of industry control devices. 


   The goal of this document is to outline the problem area of Industry control network
   end-to-end.  
  
  

# Problem Statement {#problem}

In industrial networks, a good number of devices still communicate over a serial or field bus (although Ethernet is being gradually adopted). The operations on these devices are performed by writing provide direct access to operation-control. i.e what operation to perform is embedded in the type of interface itself. For instance, Profibus, Modbus networks are implicitly latency sensitive and short control-command based.

~~~~~
  ModBus
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   | address | Function  code  | data|
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

  CAN Bus (not sure)

   +-+-+-+-+-+-+-+-+-+-+--+-+-+
   |   message id  |    data  |
   +-+-+-+-+-+-+-+-+-+-+-++-+-+
   Profibus - todo.
~~~~~

Since they are localized in an area such as factory floor or a site, such networks have evolved independently and are seperated from the IT applications. The emerging trend of industrial IoT start to play a 
Describe some unique attributes of Industry control Networks.

## Heterogenity

A typical industry control network has devices of different communication interfaces, most of these devices run in client-mode connecting to a server. 

A prefered connection interface for equipment control is bus-architecture, the expectation is that the equipment and machinery to continue to operate even if it has lost communication with controlling entity. The bus interface delivers commands  deterministically from a controller to the device and vice-a-versa. Interfaces of this kind have typically shorter addresses (upto 256 devices on a single bus in Modbus).

Some of the servers also behave as protocol gateways and interconnect different type of protocols. For example when a modbus device is being controlled by a profinet server, an gateway function will translate modbus data or encapsulate it over IP (if the controller supports it).

## OT/IT Convergence 
Most of the factory floors are not equipped with IT servers to perform compute intensive tasks. Yet an IP-based device need to connect with non-IP interface to control those devices. 

  * Many of the standard IP based protocols maybe too much overhead for OT devices.
  * Cannot preserve communication characteristics of devices (different device addressing scheme, realtime, IRT, message identifiers, Bus-like properties).
  * It relies heavily on hierarchy network stack (network layer, transport layer, application), where as OT devices do not have any, they generally operate at data link layer or below.


## Data oriented networking
Industrial verticals keep data and control on the manufacturing floor, on a closed system. There is no easy way to forward this data to enterprise level software. 


## Difference between IoT and IIoT
1. IoT is Ad-hoc, IIoT are more structured. Each subnet connected to a controller. can also be a mix of wireless and wired devices.
2. connected IIoT devices are not power sensitive.
3. IoT relies on Fire and forget type message interface, IIoT is closed feedback loop. IIoT is written and read back for reliability.
4. Their use in high accuracy of operating machinery  make them lot more sensitive to latency.

# Address Space Requirements {#reqs}

## Short Device Addressing
Shorter addresses are inherent to industry control systems. As mentioned in Section

## Meaningful Addresses

The industry control floors are built bottom-up. The devices are carefully wired and connected to controllers. A particular type of machinery relies on Modbus subnet, the other

## Adoption of Lean Network Layer 
Challenge of Industrial network device address is that it  communicates to a physical device address. Traditionally, in a limited environment there was no need for network layer or expressing network specific service, access control. 
* If a sensor is broken, it will require reprogramming of controller and re-aligning with the new address. The benefit of network layer, removes this restriction. 
* Note that, using IP stack is not suitable because these devices perform specific functions and any overhead in transport or large addressing can add to processing delays.
* Several other IP suite protocols such as device discovery should be revisited.


## Multi-semantic behavior
OT networks, at least at site level are organized at much smaller scale than typical IP-capable networks. There is in turn a fixed hierarchy of networks w.r.t. location in a plant.

## Interoperability with IP world machines
(OT-Address)--->(IP)--->(OT-Address) 

# Relationship with Relevant IETF Groups {#relevance}

## Deterministic Networks (DetNet WG)
The Deterministic Networking (DetNet) Working Group is working on using IP for long-range connectivity with  bounded latency in industry control networks {{DETNET-ARCH}}. The scope of DetNet includes developing specifications for  the data plane {{DETNET-DP}}, OAM
(Operations, Administration, and Maintenance), time synchronization,
management, control, and security aspects over a
multi-hop path forwarding. The characteristics include  controlled latency, low packet loss, low packet delay
variation, and high reliability. 

## IoT OPS

## LPWAN



#IANA Considerations

This document requires no actions from IANA.

#Security Considerations

This document introduces no new security issues.

#Acknowledgements

Thanks to ---.

--- back

