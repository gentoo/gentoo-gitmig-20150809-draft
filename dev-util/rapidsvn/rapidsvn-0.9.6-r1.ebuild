# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/rapidsvn/rapidsvn-0.9.6-r1.ebuild,v 1.9 2010/06/22 20:04:56 arfrever Exp $

WANT_AUTOCONF="2.5"
WX_GTK_VER=2.8
inherit versionator eutils libtool autotools wxwidgets flag-o-matic fdo-mime

DESCRIPTION="Cross-platform GUI front-end for the Subversion revision system."
HOMEPAGE="http://rapidsvn.tigris.org/"
SRC_URI="http://www.rapidsvn.org/download/release/${PV}/${P}.tar.gz"
LICENSE="GPL-2 LGPL-2.1 FDL-1.2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE="doc static"

COMMON_DEP=">=dev-vcs/subversion-1.4.4
	>=net-libs/neon-0.26
	=x11-libs/wxGTK-2.8*
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
	if ! built_with_use --missing true -o dev-vcs/subversion webdav-neon webdav-serf || \
	built_with_use --missing false dev-vcs/subversion nowebdav; then
		ewarn "SVN (dev-vcs/subversion) must be compiled with WebDAV support."
		ewarn "Please re-emerge subversion with webdav-neon or webdav-serf USE flag"
		ewarn "and without the nowebdav USE flag."
		die "SVN merged without WebDAV support"
	else
		einfo "Found WebDAV support; continuing..."
	fi

	# if you compiled subversion without (the) apache2 (flag) and with the
	# berkdb flag, you will get an error that it can't find the lib db4
	# Note: this should be fixed in rapidsvn 0.9.3 and later

	# check for the proper wxGTK support
	need-wxwidgets unicode
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Apparently we still need the --as-needed link patch...
	epatch "${FILESDIR}/${PN}-svncpp_link.patch"
	epatch "${FILESDIR}/${PN}-sar.patch"
	eautoconf
	elibtoolize
}

src_compile() {
	local myconf
	local apr_suffix=""

	if has_version ">dev-libs/apr-util-1"; then
		apr_suffix="-1"
	fi

	if ! use doc; then
		myconf="--without-xsltproc --without-doxygen --without-dot"
	fi

	if use static; then
		myconf="${myconf} --enable-static"
	else
		myconf="${myconf} --disable-static --enable-shared"
	fi

	myconf="${myconf} --with-wx-config=${WX_CONFIG}"

	append-flags $( /usr/bin/apr${apr_suffix}-config --cppflags )

	econf	--with-svn-lib=/usr/$(get_libdir) \
		--with-svn-include=/usr/include \
		--with-neon-config=/usr/bin/neon-config \
		--with-apr-config="/usr/bin/apr${apr_suffix}-config" \
		--with-apu-config="/usr/bin/apu${apr_suffix}-config" \
		${myconf} || die "econf failed"

	emake  || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"

	doman doc/manpage/rapidsvn.1 || die "doman failed"

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
