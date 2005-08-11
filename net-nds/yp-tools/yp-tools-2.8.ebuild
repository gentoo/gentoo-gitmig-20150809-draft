# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/yp-tools/yp-tools-2.8.ebuild,v 1.14 2005/08/11 18:26:19 eradicator Exp $

IUSE="nls"

DESCRIPTION="Network Information Service tools"
HOMEPAGE="http://www.linux-nis.org/nis/"
SRC_URI="ftp://ftp.kernel.org/pub/linux/utils/net/NIS/OLD/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"

DEPEND="virtual/libc"

src_compile() {
	local myconf="--sysconfdir=/etc/yp"
	if ! use nls
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
	econf ${myconf} || die "econf failed"
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
	insinto /etc/yp ; doins etc/nicknames
	# This messes up boot so we remove it
	rm -d ${D}/bin/ypdomainname
	rm -d ${D}/bin/nisdomainname
	rm -d ${D}/bin/domainname
}
