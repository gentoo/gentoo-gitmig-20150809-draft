# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/gnucash/gnucash-1.6.7.ebuild,v 1.1 2002/08/19 00:01:11 spider Exp $

inherit flag-o-matic


S=${WORKDIR}/${P}
DESCRIPTION="A personal finance manager"
SRC_URI="http://download.sourceforge.net/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnucash.org/"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

RDEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1
	 >=dev-libs/libxml-1.8.3
	 >=gnome-extra/gtkhtml-0.14.0-r1
	 >=gnome-extra/gal-0.13-r1
	 >=gnome-extra/guppi-0.35.5-r2
	 >=gnome-base/gnome-print-0.21
	 postgres? ( dev-db/postgresql )"

DEPEND="${RDEPEND}
	>=sys-devel/perl-5
	>=dev-libs/slib-2.3.8
	>=dev-lang/swig-1.3_alpha4
	>=dev-libs/g-wrap-1.1.5
	<gnome-base/libglade-2
	media-libs/gdk-pixbuf
	dev-util/guile
	gnome-base/libghttp
	nls? ( sys-devel/gettext )"


# won't configure with this
filter-flags -fomit-frame-pointer

src_unpack() {
	unpack ${A}

	cd ${S}/src/guile
	cp argv-list-converters.c argv-list-converters.c.old
	sed -e "s,printf,g_print,g" \
		argv-list-converters.c.old > argv-list-converters.c
	rm argv-list-converters.c.old
}

src_compile() {
	local myconf=""

	use nls      || myconf="--disable-nls"
	use postgres && myconf="$myconf --enable-sql"

	econf --enable-profile \
		--enable-rpc \
		$myconf || die "Configuration failed"

	make || die # Doesn't work with make -j 4 (hallski)
}

src_install () {
    einstall || die "Installation failed"

    dodoc ABOUT-NLS AUTHORS COPYING ChangeLog HACKING NEWS README* TODO
}
