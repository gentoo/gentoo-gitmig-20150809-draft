# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/gkrellm/gkrellm-2.1.7a.ebuild,v 1.2 2003/02/18 08:06:04 seemant Exp $

DESCRIPTION="Single process stack of various system monitors"
SRC_URI="http://web.wt.net/~billw/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gkrellm.net/"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc alpha ~sparc"
IUSE="gtk gtk2 nls"

DEPEND=">=sys-apps/sed-4.0.5
	gtk? (  >=x11-libs/gtk+-2.0.5 )
	gtk2? ( >=x11-libs/gtk+-2.0.5 )"
RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {

	use nls || sed -i "s:enable_nls=1:enable_nls=0:" Makefile
	
	if use gtk2 || use gtk
	then
		emake || die
	else
		cd ${S}/server
		emake glib12=1 || die
	fi
}

src_install() {
	dodir /usr/{bin,include,share/man}

	make \
		INSTALLDIR=${D}/usr/bin \
		SINSTALLDIR=${D}/usr/bin \
		MANDIR=${D}/usr/share/man/man1 \
		SMANDIR=${D}/usr/share/man/man1 \
		INCLUDEDIR=${D}/usr/include \
		LOCALEDIR=${D}/usr/share/locale \
		install || die

	rm -f ${D}/usr/share/man/man1/*
	doman *.1

	if use gtk2 || use gtk
	then
		keepdir /usr/share/gkrellm2/themes
		keepdir /usr/lib/gkrellm2/plugins
		cd ${S}
		mv gkrellm.1 gkrellm2.1
		
		rm -f ${D}/usr/bin/gkrellm
		exeinto /usr/bin
		newexe src/gkrellm gkrellm2
	else
		cd ${S}
		rm gkrellm.1
	fi

	# The GKrellM daemon
	into /usr
#	dobin server/gkrellmd
	exeinto /etc/init.d
	doexe ${FILESDIR}/gkrellmd
	insinto /etc
	doins server/gkrellmd.conf

	dodoc COPYRIGHT README Changelog
	dohtml *.html
}
