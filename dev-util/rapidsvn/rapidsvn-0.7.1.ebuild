# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/rapidsvn/rapidsvn-0.7.1.ebuild,v 1.2 2005/05/31 06:28:27 nerdboy Exp $

inherit eutils libtool

DESCRIPTION="Cross-platform GUI front-end for the Subversion revision system."
HOMEPAGE="http://rapidsvn.tigris.org/"
SRC_URI="http://www.rapidsvn.org/download/${P}.tar.gz"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE="doc gtk2"

DEPEND=">=dev-util/subversion-1.0.0
	>=x11-libs/wxGTK-2.4.2-r2
	doc? ( dev-libs/libxslt app-text/docbook-sgml-utils app-doc/doxygen app-text/docbook-xsl-stylesheets )"

src_unpack() {
	cd ${WORKDIR}
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/svncpp_0.6.1_link.patch
}

src_compile() {
	# if you compiled subversion without (the) apache2 (flag) and with the berkdb flag
	# you will get an error that it can't find the lib db4
	local myconf
	local xslss_dir

	if use doc; then
		xslss_dir=$(ls -1d /usr/share/sgml/docbook/xsl-stylesheets*|head -n1)
		myconf="--with-docbook-xsl=$xslss_dir"
	else
		myconf="--without-xsltproc --without-docbook-xsl --without-doxygen \
			--without-dot"
	fi
	if use gtk2; then
		if test -x /usr/bin/wxgtk2-2.4-config; then
			myconf="${myconf} --with-wx-config=/usr/bin/wxgtk2-2.4-config"
		else
			ewarn "wxgtk2-2.4-config not found. Compiling with default wxGTK."
		fi
	elif test -x /usr/bin/wxgtk-2.4-config; then
		myconf="${myconf} --with-wx-config=/usr/bin/wxgtk-2.4-config"
	else
		ewarn "wxgtk-2.4-config not found. Compiling with default wxGTK."
	fi
	elibtoolize --portage

	econf	--with-svn-lib=/usr/lib \
		--with-svn-include=/usr/include \
		${myconf} || die "./configure failed"
	emake  || die
}

src_install() {
	einstall || die
	doicon src/res/bitmaps/svn.xpm
	make_desktop_entry rapidsvn RapidSVN svn.xpm RevisionControl
	if use doc ; then
		cd ${S}
		dodir /usr/share/doc/${PF}/svncpp
		cp -r ${S}/doc/svncpp/html ${D}/usr/share/doc/${PF}/svncpp
	fi
}
