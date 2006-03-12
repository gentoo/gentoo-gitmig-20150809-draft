# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nxserver-freenx/nxserver-freenx-0.5.0.ebuild,v 1.3 2006/03/12 22:04:57 swegener Exp $

inherit eutils

DESCRIPTION="An X11/RDP/VNC proxy server especially well suited to low bandwidth links such as ISDN or modem"
HOMEPAGE="http://freenx.berlios.de/"
SRC_URI="http://debian.tu-bs.de/knoppix/nx/lwe-release/FreeNX-0_5_0-LWE.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
RESTRICT="nomirror strip"
IUSE="commercial"
DEPEND="virtual/ssh
	dev-tcltk/expect
	net-analyzer/gnu-netcat
	x86? ( commercial? ( >=net-misc/nxclient-1.4 )
	      !commercial? ( !net-misc/nxclient ) )
	!x86? ( !net-misc/nxclient )
	>=net-misc/nxproxy-1.4.0
	>=net-misc/nx-x11-1.4.0
	!net-misc/nxserver-personal
	!net-misc/nxserver-business
	!net-misc/nxserver-enterprise"

S=${WORKDIR}/FreeNX-0_5_0-LWE/freenx-server

pkg_setup () {
	enewuser nx -1 -1 /usr/NX/home/nx
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch gentoo-nomachine.diff
}

src_compile() {
	einfo "Nothing to compile"
}

src_install() {

	NX_DIR=/usr/NX
	NX_ETC_DIR=$NX_DIR/etc
	NX_SESS_DIR=$NX_DIR/var/db
	NX_HOME_DIR=$NX_DIR/home/nx

	into ${NX_DIR}
	dobin nxserver
	dobin nxnode
	dobin nxnode-login
	dobin nxkeygen
	dobin nxloadconfig
	dobin nxsetup
	( use x86 && use commercial ) || dobin nxprint
	( use x86 && use commercial ) || dobin nxclient

	doenvd ${FILESDIR}/50nxserver

	dodir ${NX_ETC_DIR}
	for x in passwords passwords.orig ; do
		touch ${D}${NX_ETC_DIR}/$x
		chmod 600 ${D}${NX_ETC_DIR}/$x
	done

	insinto ${NX_ETC_DIR}
	doins node.conf.sample

	ssh-keygen -f ${D}${NX_ETC_DIR}/users.id_dsa -t dsa -N "" -q

	for x in closed running failed ; do
		keepdir ${NX_SESS_DIR}/$x
		fperms 0700 ${NX_SESS_DIR}/$x
	done

	dodir ${NX_HOME_DIR}/.ssh
	fperms 0700 ${NX_HOME_DIR}
	fperms 0700 ${NX_HOME_DIR}/.ssh

	cat << EOF >${D}${NX_HOME_DIR}/.ssh/server.id_dsa.pub.key
ssh-dss AAAAB3NzaC1kc3MAAACBAJe/0DNBePG9dYLWq7cJ0SqyRf1iiZN/IbzrmBvgPTZnBa5FT/0Lcj39sRYt1paAlhchwUmwwIiSZaON5JnJOZ6jKkjWIuJ9MdTGfdvtY1aLwDMpxUVoGwEaKWOyin02IPWYSkDQb6cceuG9NfPulS9iuytdx0zIzqvGqfvudtufAAAAFQCwosRXR2QA8OSgFWSO6+kGrRJKiwAAAIEAjgvVNAYWSrnFD+cghyJbyx60AAjKtxZ0r/Pn9k94Qt2rvQoMnGgt/zU0v/y4hzg+g3JNEmO1PdHh/wDPVOxlZ6Hb5F4IQnENaAZ9uTZiFGqhBO1c8Wwjiq/MFZy3jZaidarLJvVs8EeT4mZcWxwm7nIVD4lRU2wQ2lj4aTPcepMAAACANlgcCuA4wrC+3Cic9CFkqiwO/Rn1vk8dvGuEQqFJ6f6LVfPfRTfaQU7TGVLk2CzY4dasrwxJ1f6FsT8DHTNGnxELPKRuLstGrFY/PR7KeafeFZDf+fJ3mbX5nxrld3wi5titTnX+8s4IKv29HJguPvOK/SI7cjzA+SqNfD7qEo8= root@nettuno
EOF
	fperms 0600 ${NX_HOME_DIR}/.ssh/server.id_dsa.pub.key
	cp ${D}${NX_HOME_DIR}/.ssh/server.id_dsa.pub.key ${D}${NX_HOME_DIR}/.ssh/authorized_keys2
	fperms 0600 ${NX_HOME_DIR}/.ssh/authorized_keys2

	echo -n "127.0.0.1" ${D}${NX_HOME_DIR}/.ssh/known_hosts

	chown -R nx:root ${D}${NX_DIR}
}

pkg_postinst () {
	usermod -s /usr/NX/bin/nxserver nx || die "Unable to set login shell of nx user!!"

	echo
	einfo "If you are using NX version 1.5.0, make sure you edit the file:"
	einfo "/usr/NX/etc/node.conf and set ENABLE_1_5_0_BACKEND to 1."
	echo
}
