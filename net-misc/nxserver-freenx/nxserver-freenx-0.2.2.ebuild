# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nxserver-freenx/nxserver-freenx-0.2.2.ebuild,v 1.2 2004/11/24 21:59:15 swegener Exp $

inherit eutils

DESCRIPTION="Windows Remote Desktop for X11"
HOMEPAGE="http://www.kalyxo.org/twiki/bin/view/Main/FreeNX"
SRC_URI="http://debian.tu-bs.de/knoppix/nx/freenx-0.2-2.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="net-misc/nx-x11
		>=net-misc/nxclient-1.4
		>=net-misc/nxssh-1.4.0
		dev-tcltk/expect"

S=${WORKDIR}/freenx-0.2-3

pkg_setup () {
	enewuser nx -1 /bin/false /usr/NX/home/nx
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

	NX_ROOT_DIR="/usr/NX"
	NX_BIN_DIR=${NX_ROOT_DIR}/bin
	NX_ETC_DIR=${NX_ROOT_DIR}/etc
	NX_HOME_ROOT=${NX_ROOT_DIR}/home
	NX_HOME_DIR=${NX_HOME_ROOT}/nx
	NX_SSH_DIR=${NX_HOME_DIR}/.ssh
	NX_SESS_DIR=${NX_ROOT_DIR}/var/db

	# our job here is to make this package look as much like the commercial
	# nxserver as possible
	#
	# this means we only have to maintain the one pkg_postinst() function
	# for both the commercial and gpl'd servers :)

	into $NX_ROOT_DIR
	dobin nxserver
	dobin nxnode
	dobin nxnode-login
	dobin nxkeygen

	dodir ${NX_ETC_DIR}
	for x in passwords passwords.orig ; do
		touch ${D}${NX_ETC_DIR}/$x
		chmod 600 ${D}${NX_ETC_DIR}/$x
	done

	ssh-keygen -f ${D}${NX_ETC_DIR}/users.id_dsa -t dsa -N "" -q

	for x in closed running failed ; do
		keepdir ${NX_SESS_DIR}/$x
		fperms 0700 ${NX_SESS_DIR}/$x
	done

	dodir ${NX_SSH_DIR}
	fperms 0700 ${NX_HOME_DIR}
	fperms 0700 ${NX_SSH_DIR}

	cat << EOF >${D}${NX_SSH_DIR}/server.id_dsa.pub.key
ssh-dss AAAAB3NzaC1kc3MAAACBAJe/0DNBePG9dYLWq7cJ0SqyRf1iiZN/IbzrmBvgPTZnBa5FT/0Lcj39sRYt1paAlhchwUmwwIiSZaON5JnJOZ6jKkjWIuJ9MdTGfdvtY1aLwDMpxUVoGwEaKWOyin02IPWYSkDQb6cceuG9NfPulS9iuytdx0zIzqvGqfvudtufAAAAFQCwosRXR2QA8OSgFWSO6+kGrRJKiwAAAIEAjgvVNAYWSrnFD+cghyJbyx60AAjKtxZ0r/Pn9k94Qt2rvQoMnGgt/zU0v/y4hzg+g3JNEmO1PdHh/wDPVOxlZ6Hb5F4IQnENaAZ9uTZiFGqhBO1c8Wwjiq/MFZy3jZaidarLJvVs8EeT4mZcWxwm7nIVD4lRU2wQ2lj4aTPcepMAAACANlgcCuA4wrC+3Cic9CFkqiwO/Rn1vk8dvGuEQqFJ6f6LVfPfRTfaQU7TGVLk2CzY4dasrwxJ1f6FsT8DHTNGnxELPKRuLstGrFY/PR7KeafeFZDf+fJ3mbX5nxrld3wi5titTnX+8s4IKv29HJguPvOK/SI7cjzA+SqNfD7qEo8= root@nettuno
EOF
	fperms 0600 ${NX_SSH_DIR}/server.id_dsa.pub.key
	cp ${D}${NX_SSH_DIR}/server.id_dsa.pub.key ${D}${NX_SSH_DIR}/authorized_keys2
	fperms 0600 ${NX_SSH_DIR}/authorized_keys2

	echo -n "127.0.0.1" ${D}${NX_SSH_DIR}/known_hosts

	chown -R nx:root ${D}/usr/NX

}

pkg_postinst () {
	usermod -s /usr/NX/bin/nxserver nx || die "Unable to set login shell of nx user!!"
}
