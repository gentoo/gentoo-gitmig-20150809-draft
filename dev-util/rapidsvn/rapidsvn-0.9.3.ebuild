# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/rapidsvn/rapidsvn-0.9.3.ebuild,v 1.23 2008/04/30 20:42:07 hollow Exp $

inherit eutils libtool autotools wxwidgets flag-o-matic fdo-mime

DESCRIPTION="Cross-platform GUI front-end for the Subversion revision system."
HOMEPAGE="http://rapidsvn.tigris.org/"
SRC_URI="http://www.rapidsvn.org/download/${P}.tar.gz"
LICENSE="GPL-2 LGPL-2.1 FDL-1.2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE="doc static"

DEPEND=">=dev-util/subversion-1.4.0
	>=net-misc/neon-0.26
	=x11-libs/wxGTK-2.6*
	>=dev-libs/apr-1.2.10
	>=dev-libs/apr-util-1.2.10
	doc? ( dev-libs/libxslt
	    app-text/docbook-sgml-utils
	    app-doc/doxygen
	    app-text/docbook-xsl-stylesheets )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Apparently we still the --as-needed link patch...
	epatch "${FILESDIR}/${PN}"-svncpp_link.patch || die "epatch failed"

	export WANT_AUTOCONF=2.5
	autoconf
	elibtoolize
}

src_compile() {
	einfo "Checking for subversion compiled with WebDAV support..."
	if ! built_with_use --missing true -o dev-util/subversion webdav-neon webdav-serf || \
	built_with_use --missing false dev-util/subversion nowebdav; then
		ewarn "SVN (dev-util/subversion) must be compiled with WebDAV support."
		ewarn "Please re-emerge subversion with webdav-neon or webdav-serf USE flag"
		ewarn "and without the nowebdav USE flag."
		die "SVN merged without WebDAV support"
	else
		einfo "Found WebDAV support; continuing..."
	fi

	# if you compiled subversion without (the) apache2 (flag) and with the
	# berkdb flag, you will get an error that it can't find the lib db4
	# Note: this should be fixed in rapidsvn 0.9.3 and later
	local myconf
	local xslss_dir

	if use doc; then
		xslss_dir=$(ls -1d /usr/share/sgml/docbook/xsl-stylesheets*|head -n1)
		myconf="--with-docbook-xsl=$xslss_dir"
	else
		myconf="--without-xsltproc --without-docbook-xsl \
			--without-doxygen --without-dot"
	fi
	if use static; then
		myconf="${myconf} --enable-static"
	else
		myconf="${myconf} --disable-static --enable-shared"
	fi

	export WX_GTK_VER="2.6"
	need-wxwidgets gtk2
	myconf="${myconf} --with-wx-config=${WX_CONFIG}"

	append-flags $( /usr/bin/apr-1-config --cppflags )

	econf	--with-svn-lib=/usr/$(get_libdir) \
		--with-svn-include=/usr/include \
		--with-neon-config=/usr/bin/neon-config \
		--with-apr-config=/usr/bin/apr-1-config \
		--with-apu-config=/usr/bin/apu-1-config \
		${myconf} || die "econf failed"

	emake  || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"

	doman doc/manpage/rapidsvn.1 || die "doman failed"

	doicon src/res/bitmaps/svn.xpm
	make_desktop_entry rapidsvn "RapidSVN ${PV}" \
	    "/usr/share/pixmaps/svn.xpm" \
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
