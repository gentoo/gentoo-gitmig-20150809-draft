# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/yp-tools/yp-tools-2.7-r1.ebuild,v 1.10 2004/04/05 02:29:45 agriffis Exp $

S=${WORKDIR}/${P}
DESCRIPTION="NIS Tools"
SRC_URI="mirror://kernel/linux/utils/net/NIS/${P}.tar.bz2"
HOMEPAGE="http://www.linux-nis.org/nis"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc alpha ~ppc ia64"

DEPEND="virtual/glibc"

src_compile() {
	local myconf="--sysconfdir=/etc/yp"
	if [ -z "`use nls`" ]
	then
		myconf="${myconf} --disable-nls"
		mkdir intl
		touch intl/libintl.h
		export CPPFLAGS="${CPPFLAGS} -I${S}"

		for i in lib/nicknames.c src/*.c
		do
			cp ${i} ${i}.orig
			sed 's:<libintl.h>:<intl/libintl.h>:' \
				${i}.orig > ${i}
		done
	fi
	econf ${myconf}
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING NEWS README THANKS TODO
	insinto /etc/yp ; doins etc/nicknames
	# This messes up boot so we remove it
	rm -d ${D}/bin/ypdomainname
	rm -d ${D}/bin/nisdomainname
	rm -d ${D}/bin/domainname
}
