# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nxserver-personal/nxserver-personal-1.3.0_beta2.ebuild,v 1.4 2004/03/10 22:02:23 stuart Exp $

MY_PV="${PV}-72"

inherit nxserver

KEYWORDS="~x86"

SRC_URI="http://www.nomachine.com/download/beta/nxserver-linux-binaries-beta2/nxserver-1.3.0-4-beta2.i386.tar.gz"

DEPEND="$DEPEND
	!net-misc/nxserver-business
	!net-misc/nxserver-personal
	=net-misc/nxssh-1.3.0_beta2
	>=net-misc/nxproxy-1.3.0_beta2"

RESTRICT="$RESTRICT"

S="${WORKDIR}/nxserver-install"

src_unpack ()
{
	unpack ${A}
}

src_install ()
{
	einfo "Installing"
	find NX/lib -type l -exec rm {} \;
	mv NX/etc/passwd.sample NX/etc/passwd
	mkdir ${D}/usr
	tar -cf - * | ( cd ${D}/usr ; tar -xf - )

	dodir /usr/NX/var
	dodir /usr/NX/var/sessions
	touch ${D}/usr/NX/var/sessions/NOT_EMPTY

	insinto /etc/env.d
	#doins ${FILESDIR}/${PV}/50nxserver

	fperms 0600 NX/etc/passwd
}

