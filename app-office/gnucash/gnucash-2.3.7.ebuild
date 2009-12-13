# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/gnucash/gnucash-2.3.7.ebuild,v 1.2 2009/12/13 22:09:26 ssuominen Exp $

EAPI=2

inherit eutils gnome2

DOC_VER="2.2.0"

DESCRIPTION="A personal finance manager"
HOMEPAGE="http://www.gnucash.org/"
#SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
SRC_URI="http://www.gnucash.org/pub/gnucash/sources/unstable/2.3.x/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"

IUSE="+doc ofx hbci chipcard debug quotes sqlite postgres mysql webkit"

# FIXME: rdepend on dev-libs/qof when upstream fix their mess (see configure.in)

RDEPEND=">=dev-libs/glib-2.6.3
	>=dev-scheme/guile-1.8.3[deprecated,regex]
	dev-scheme/guile-www
	>=dev-scheme/slib-3.1.4
	>=sys-libs/zlib-1.1.4
	>=dev-libs/popt-1.5
	>=x11-libs/gtk+-2.10
	>=gnome-base/libgnomeui-2.4
	>=gnome-base/libglade-2.4
	>=dev-libs/libxml2-2.5.10
	>=gnome-base/gconf-2
	>=x11-libs/goffice-0.6[gnome]
	ofx? ( >=dev-libs/libofx-0.7.0 )
	hbci? ( || ( net-libs/aqbanking[qt4] net-libs/aqbanking[qt3] )
		chipcard? ( sys-libs/libchipcard )
	)
	quotes? ( dev-perl/DateManip
		>=dev-perl/Finance-Quote-1.11
		dev-perl/HTML-TableExtract )
	webkit? ( net-libs/webkit-gtk )
	!webkit? ( >=gnome-extra/gtkhtml-3.14 )
	sqlite? ( dev-db/libdbi dev-db/libdbi-drivers[sqlite3] )
	postgres? ( dev-db/libdbi dev-db/libdbi-drivers[postgres] )
	mysql? ( dev-db/libdbi dev-db/libdbi-drivers[mysql] )
	media-libs/libart_lgpl
	x11-libs/pango"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/libtool
	>=app-text/scrollkeeper-0.3"

PDEPEND="doc? ( >=app-doc/gnucash-docs-${DOC_VER} )"
ELTCONF="--patch-only"
DOCS="doc/README.OFX doc/README.HBCI"

# FIXME: no the best thing to do but it'd be even better to fix autofoo
#MAKEOPTS="${MAKEOPTS} -j1"

pkg_setup() {
	ewarn "This is one of several unstable 2.3.x releases of the GnuCash Free"
	ewarn "Accounting Software which will eventually lead to the stable version"
	ewarn "2.4.0."
	ewarn "This release is intended for developers and testers who want to help"
	ewarn "tracking down all those bugs that are still in there."
	ewarn ""
	ewarn "WARNING WARNING WARNING"
	ewarn "Make sure you make backups of any files used in testing versions of"
	ewarn "GnuCash in the 2.3.x series."

	if use webkit ; then
		G2CONF="${G2CONF} --with-html-engine=webkit"
	else
		G2CONF="${G2CONF} --with-html-engine=gtkhtml"
	fi

	if use sqlite || use mysql || use postgres ; then
		G2CONF="${G2CONF}
			--enable-dbi"
	fi
	G2CONF="${G2CONF}
		$(use_enable debug)
		$(use_enable ofx)
		$(use_enable hbci aqbanking)
		--disable-doxygen
		--enable-locale-specific-tax
		--disable-error-on-warning"
}

src_test() {
	GUILE_WARN_DEPRECATED=no \
	GNC_DOT_DIR="${T}"/.gnucash \
	emake check \
	|| die "Make check failed. See above for details."
}

src_install() {
	gnome2_src_install GNC_DOC_INSTALL_DIR=/usr/share/doc/${PF}

	rm -rf "${D}"/usr/share/doc/${PF}/{examples/,COPYING,INSTALL,*win32-bin.txt,projects.html}
#	prepalldocs
	mv "${D}"/usr/share/doc/${PF} "${T}"/cantuseprepalldocs || die
	dodoc "${T}"/cantuseprepalldocs/* || die
}
