# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/XWine/XWine-0.3.2-r1.ebuild,v 1.1 2004/10/31 02:12:18 vapier Exp $

inherit eutils

DESCRIPTION="GTK+ frontend for Wine"
HOMEPAGE="http://darken33.free.fr/"
SRC_URI="http://darken33.free.fr/logiciels/${P}_en.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="nls"

DEPEND="=x11-libs/gtk+-1*
	sys-devel/bison
	>=gnome-base/gnome-libs-1.4.2
	=gnome-base/orbit-0*
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${P}_en

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-wine-update.patch
	epatch ${FILESDIR}/${PV}-missing-paren.patch
	make distclean || die "distclean"
	sed -i \
		-e 's: /usr/share/: $(DESTDIR)/usr/share/:g' \
		-e "s:/doc/\$(PACKAGE):/doc/${PF}:g" \
		Makefile.in || die
}

src_compile() {
	econf $(use_enable nls) || die
	emake || die
}

src_install() {
	dodir /usr/share/applications
	make install DESTDIR="${D}" || die
}
