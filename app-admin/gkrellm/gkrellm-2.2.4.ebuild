# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/gkrellm/gkrellm-2.2.4.ebuild,v 1.11 2005/04/01 01:43:53 agriffis Exp $

inherit eutils

S=${WORKDIR}/${P/a/}
DESCRIPTION="Single process stack of various system monitors"
HOMEPAGE="http://www.gkrellm.net/"
SRC_URI="http://web.wt.net/~billw/gkrellm/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="x86 ppc alpha sparc hppa amd64 ia64 ppc64 ~mips"
IUSE="X nls ssl"

DEPEND=">=sys-apps/sed-4
	ssl? ( dev-libs/openssl )
	X? (  >=x11-libs/gtk+-2.0.5
		>=x11-libs/pango-1.4.0 )"
RDEPEND="${DEPEND}
	nls? ( sys-devel/gettext )"

src_compile() {
	local myconf
	if ! use nls; then
		sed -i "s:enable_nls=1:enable_nls=0:" Makefile
	fi

	sed -i 's:INSTALLROOT ?= /usr/local:INSTALLROOT ?= ${D}/usr:' Makefile

	if use X
	then
	use ssl || myconf="without-ssl=yes"
		PREFIX=/usr emake ${myconf} || die
	else
		cd ${S}/server
		emake glib12=1 || die
	fi
}

src_install() {
	dodir /usr/{bin,include,share/man}

	if use X
	then
		keepdir /usr/share/gkrellm2/themes
		keepdir /usr/lib/gkrellm2/plugins

		make DESTDIR=${D} install \
			INSTALLDIR=${D}/usr/bin \
			MANDIR=${D}/usr/share/man/man1 \
			INCLUDEDIR=${D}/usr/include \
			LOCALEDIR=${D}/usr/share/locale \
			PKGCONFIGDIR=${D}/usr/lib/pkgconfig

		cd ${S}
		mv gkrellm.1 gkrellm2.1

		mv src/gkrellm src/gkrellm2
		dobin src/gkrellm2
		rm -f ${D}/usr/bin/gkrellm
	else
		cd ${S}/server
		dobin gkrellmd
		cd ${S}
		rm gkrellm.1
	fi

	rm -f ${D}/usr/share/man/man1/*
	doman *.1

	exeinto /etc/init.d
	doexe ${FILESDIR}/gkrellmd

	insinto /etc
	doins server/gkrellmd.conf

	dodoc COPYRIGHT CREDITS INSTALL README Changelog
	dohtml *.html
}
