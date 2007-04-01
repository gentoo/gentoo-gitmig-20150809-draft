# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/rapidsvn/rapidsvn-0.9.4.ebuild,v 1.4 2007/04/01 00:59:40 nerdboy Exp $

inherit eutils libtool autotools

DESCRIPTION="Cross-platform GUI front-end for the Subversion revision system."
HOMEPAGE="http://rapidsvn.tigris.org/"
SRC_URI="http://www.rapidsvn.org/download/release/${PV}/${P}.tar.gz"
LICENSE="GPL-2 LGPL-2.1 FDL-1.2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc static"

DEPEND=">=dev-util/subversion-1.3.2-r1
	>=net-misc/neon-0.26
	>=x11-libs/wxGTK-2.6.2
	<dev-libs/apr-0.9.13
	doc? ( dev-libs/libxslt
	    app-text/docbook-sgml-utils
	    app-doc/doxygen
	    app-text/docbook-xsl-stylesheets )"

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

src_unpack() {
	unpack ${A}
	cd ${S}
	# Apparently we still the --as-needed link patch...
	epatch ${FILESDIR}/${PN}-svncpp_link.patch || die "epatch failed"
	elibtoolize
	eautoreconf
}

src_compile() {
	einfo "Checking for subversion compiled with neon support..."
	if built_with_use dev-util/subversion nowebdav; then
	    ewarn "SVN (dev-util/subversion) must be compiled with neon support."
	    ewarn "Please re-emerge subversion without the nowebdav USE flag."
	    die "SVN merged with nowebdav USE flag"
	else
	    einfo "Found neon support; continuing..."
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
	# look for wx-config-2.6
	if (test -x /usr/bin/wx-config-2.6 && `/usr/bin/wx-config-2.6 --toolkit=gtk2 2>/dev/null` ); then
		myconf="${myconf} --with-wx-config=/usr/bin/wx-config-2.6"
	else
		ewarn "wx-config-2.6 not found. Compiling with default wxGTK."
	fi

	econf	--with-svn-lib=/usr/$(get_libdir) \
		--with-svn-include=/usr/include \
		--with-neon-config=/usr/bin/neon-config \
		--with-apr-config=/usr/bin/apr-config \
		${myconf} || die "econf failed"
	emake  || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
	doman doc/manpage/rapidsvn.1 || die "doman failed"
	doicon src/res/bitmaps/svn.xpm
	make_desktop_entry rapidsvn RapidSVN svn.xpm Programming
	dodoc HACKING.txt TRANSLATIONS
	if use doc ; then
	    dodoc AUTHORS CHANGES NEWS README
	    dohtml ${S}/doc/svncpp/html/*
	fi
}
