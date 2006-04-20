# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/dia/dia-0.94-r5.ebuild,v 1.1 2006/04/20 21:41:35 allanonjl Exp $

inherit eutils gnome2 libtool

DESCRIPTION="Diagram/flowchart creation program"
HOMEPAGE="http://www.gnome.org/projects/dia/"
LICENSE="GPL-2"

SRC_URI="${SRC_URI}
	mirrors://gentoo/${P}-sheets-png.tar.bz2"

SLOT="0"
KEYWORDS="~alpha ~amd64 ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="gnome png python static zlib"

RDEPEND=">=x11-libs/gtk+-2
	>=x11-libs/pango-1.1.5
	>=dev-libs/libxml2-2.3.9
	>=dev-libs/libxslt-1
	>=media-libs/freetype-2.0.9
	dev-libs/popt
	zlib? ( sys-libs/zlib )
	png? ( media-libs/libpng
		>=media-libs/libart_lgpl-2 )
	gnome? ( >=gnome-base/libgnome-2.0
		>=gnome-base/libgnomeui-2.0 )
	python? ( >=dev-lang/python-1.5.2
		>=dev-python/pygtk-1.99 )
	~app-text/docbook-xml-dtd-4.2
	app-text/docbook-xsl-stylesheets"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.21
	dev-util/pkgconfig"

G2CONF="${G2CONF} $(use_enable gnome) $(use_with python) $(use_enable static)"

DOCS="AUTHORS ChangeLog KNOWN_BUGS NEWS README RELEASE-PROCESS THANKS TODO"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Patch to fix configure.in issues with gnome support, bug 118591
	epatch ${FILESDIR}/dia-0.94-pkgconfig.patch

	# Disable python -c 'import gtk' during compile to prevent using
	# X being involved (#31589)
	epatch ${FILESDIR}/${PV}-disable_python_gtk_import.patch

	libtoolize --force --copy || die "Elibtoolize failed"

	# Install png's instead of xpm's, (bug #103401) and upstream.
	epatch ${FILESDIR}/${P}-png.patch
	cp -r ${WORKDIR}/sheets/* ${S}/sheets
	aclocal  || die "Aclocal failed"
	automake || die "Automake failed"

	# Fix generation of the man page (bug #98610).
	rm doc/en/dia.1
	epatch ${FILESDIR}/${P}-db2man.patch
	autoconf || die "Autoconf failed"

	# Disable buggy font cache. See bug #81227.
	epatch ${FILESDIR}/${P}-no_font_cache.patch
	# Fix help display. See bug #83726.
	epatch ${FILESDIR}/${P}-help.patch
	# GCC 4 compile fixes
	epatch ${FILESDIR}/${P}-gcc4.patch
	# Fix python execution hole. bug #107916
	epatch ${FILESDIR}/${P}-secure-eval.patch
	# xfig patch bug #128107
	epatch ${FILESDIR}/${P}_xfigoverflowfix.patch

}
