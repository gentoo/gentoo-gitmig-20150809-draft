# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/gkrellm/gkrellm-2.0.4.ebuild,v 1.1 2002/10/15 12:29:28 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Single process stack of various system monitors"
SRC_URI="http://web.wt.net/~billw/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gkrellm.net/"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~sparc64"

DEPEND="gtk? >=x11-libs/gtk+-2.0.5 : =dev-libs/glib-1.2*"

RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	if [ ! "`use nls`" ]; then
		cp Makefile Makefile.orig
		sed -e "s:enable_nls=1:enable_nls=0:" Makefile.orig > Makefile
	fi
	
	if use gtk
	then
		emake || die
	else
		cd ${S}/server
		emake glib12=1 || die
	fi
}

src_install () {
	touch .keep
	dodir /usr/{bin,include,share/man}

	if use gtk
	then
		insinto /usr/lib/gkrellm2/themes
		doins .keep

		insinto /usr/lib/gkrellm2/plugins
		doins .keep
		make install \
			INSTALLDIR=${D}/usr/bin \
			MANDIR=${D}/usr/share/man/man1 \
			INCLUDEDIR=${D}/usr/include \
			LOCALEDIR=${D}/usr/share/locale

		cd ${S}
		mv gkrellm.1 gkrellm2.1
		
		mv src/gkrellm src/gkrellm2
		rm -f ${D}/usr/bin/gkrellm
		dobin src/gkrellm2
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

	dodoc COPYRIGHT README Changelog
	dohtml *.html
}
