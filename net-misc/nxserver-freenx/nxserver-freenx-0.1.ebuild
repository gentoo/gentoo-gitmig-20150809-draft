# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nxserver-freenx/nxserver-freenx-0.1.ebuild,v 1.2 2004/09/07 19:28:31 stuart Exp $

# although we inherit from nxserver eclass, we override a lot of the
# functions, because that eclass is really designed to work with the
# commercial NX server

inherit nxserver-1.4

DESCRIPTION="X11 protocol compression library"
HOMEPAGE="http://www.kalyxo.org/twiki/bin/view/Main/FreeNX"
SRC_URI="http://kalyxo.freedesktop.org/debian/pool/n/nxserver/nxserver_${PV}.orig.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="net-misc/nx-x11
	    >=net-misc/nxclient-1.4.0
		>=net-misc/nxssh-1.4.0"

S=${WORKDIR}/nxserver-${PV}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/freenx-0.1-gentoo.patch
}

src_compile() {
	einfo "Nothing to compile"
}

src_install() {

	# our job here is to make this package look as much like the commercial
	# nxserver as possible
	#
	# this means we only have to maintain the one pkg_postinst() function
	# for both the commercial and gpl'd servers :)

	into /usr/NX
	dobin nxserver
	dobin nxnode

	diropts -m 0755
	dodir /usr/NX/home

	diropts -m 0700
	dodir /usr/NX/home/nx/.ssh

	cat << EOF >${D}/usr/NX/home/nx/.ssh/server.id_dsa.pub.key
no-port-forwarding,no-X11-forwarding,no-agent-forwarding,command="nxserver",ssh-dss AAAAB3NzaC1kc3MAAACBAJe/0DNBePG9dYLWq7cJ0SqyRf1iiZN/IbzrmBvgPTZnBa5FT/0Lcj39sRYt1paAlhchwUmwwIiSZaON5JnJOZ6jKkjWIuJ9MdTGfdvtY1aLwDMpxUVoGwEaKWOyin02IPWYSkDQb6cceuG9NfPulS9iuytdx0zIzqvGqfvudtufAAAAFQCwosRXR2QA8OSgFWSO6+kGrRJKiwAAAIEAjgvVNAYWSrnFD+cghyJbyx60AAjKtxZ0r/Pn9k94Qt2rvQoMnGgt/zU0v/y4hzg+g3JNEmO1PdHh/wDPVOxlZ6Hb5F4IQnENaAZ9uTZiFGqhBO1c8Wwjiq/MFZy3jZaidarLJvVs8EeT4mZcWxwm7nIVD4lRU2wQ2lj4aTPcepMAAACANlgcCuA4wrC+3Cic9CFkqiwO/Rn1vk8dvGuEQqFJ6f6LVfPfRTfaQU7TGVLk2CzY4dasrwxJ1f6FsT8DHTNGnxELPKRuLstGrFY/PR7KeafeFZDf+fJ3mbX5nxrld3wi5titTnX+8s4IKv29HJguPvOK/SI7cjzA+SqNfD7qEo8= root@nettuno
EOF
	fperms 0600 /usr/NX/home/nx/.ssh/server.id_dsa.pub.key

	for x in closed running failed ; do
		dodir /usr/NX/var/db/$x
		fperms 0600 /usr/NX/var/db/$x
	done

	dodir /usr/NX/etc
	touch ${D}/usr/NX/etc/passwords
	touch ${D}/usr/NX/etc/passwords.orig
}
