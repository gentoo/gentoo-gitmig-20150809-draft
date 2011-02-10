# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/rapidsvn/rapidsvn-0.10.0.ebuild,v 1.1 2011/02/10 21:35:45 ulm Exp $

EAPI="2"

WANT_AUTOCONF="2.5"
WX_GTK_VER=2.8
inherit versionator confutils libtool autotools wxwidgets flag-o-matic fdo-mime

MY_PV=$(get_version_component_range 1-2)
MY_RELEASE="1"

DESCRIPTION="Cross-platform GUI front-end for the Subversion revision system."
HOMEPAGE="http://rapidsvn.tigris.org/"
SRC_URI="http://www.rapidsvn.org/download/release/${MY_PV}/${P}-${MY_RELEASE}.tar.gz"
LICENSE="GPL-2 LGPL-2.1 FDL-1.2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"

COMMON_DEP="|| ( >=dev-vcs/subversion-1.5.0[webdav-serf]
		>=dev-vcs/subversion-1.5.0[webdav-neon]
	)
	x11-libs/wxGTK:2.8[X]
	>=dev-libs/apr-1.2.10
	>=dev-libs/apr-util-1.2.10"

DEPEND="${COMMON_DEP}
	doc? ( dev-libs/libxslt
		app-text/docbook-sgml-utils
		app-doc/doxygen
		app-text/docbook-xsl-stylesheets )"

RDEPEND="${COMMON_DEP}"

RESTRICT=""

pkg_setup() {
	einfo "Checking for subversion compiled with WebDAV support..."
	confutils_require_built_with_any \
		dev-vcs/subversion webdav-serf webdav-neon
	einfo "Found WebDAV support; continuing..."

	# if you compiled subversion without (the) apache2 (flag) and with the
	# berkdb flag, you may get an error that it can't find the lib db4
	# Note: this should be fixed in rapidsvn 0.9.3 and later

	# check for the proper wxGTK support
	need-wxwidgets unicode
}

src_prepare() {
	# Apparently we still need the --as-needed link patch...
	#export EPATCH_OPTS="-F3 -l"
	epatch "${FILESDIR}/${PN}-svncpp_link.patch"
	epatch "${FILESDIR}/${PN}-0.9.8-sar.patch"
	eautoreconf
}

src_configure() {
	local myconf
	local apr_suffix=""

	if has_version ">dev-libs/apr-util-1"; then
		apr_suffix="-1"
	fi

	if use doc; then
		myconf="--with-manpage=yes"
	else
		myconf="--without-xsltproc --with-manpage=no \
		    --without-doxygen --without-dot"
	fi

	myconf="${myconf} --with-wx-config=${WX_CONFIG}"

	append-flags $( /usr/bin/apr${apr_suffix}-config --cppflags )

	econf	--with-svn-lib=/usr/$(get_libdir) \
		--with-svn-include=/usr/include \
		--with-apr-config="/usr/bin/apr${apr_suffix}-config" \
		--with-apu-config="/usr/bin/apu${apr_suffix}-config" \
		${myconf} || die "econf failed"
}

src_compile() {
	emake  || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"

	doicon src/res/rapidsvn.ico
	make_desktop_entry rapidsvn "RapidSVN ${PV}" \
		"/usr/share/pixmaps/rapidsvn.ico" \
		"RevisionControl;Development"

	dodoc HACKING.txt TRANSLATIONS

	if use doc ; then
		dodoc AUTHORS CHANGES NEWS README
		dohtml "${S}"/doc/svncpp/html/*
	fi
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
