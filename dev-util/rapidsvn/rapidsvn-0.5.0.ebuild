# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/rapidsvn/rapidsvn-0.5.0.ebuild,v 1.1 2004/02/08 21:09:31 iggy Exp $

DESCRIPTION="Cross-platform GUI front-end for the Subversion revision system."
HOMEPAGE="http://rapidsvn.tigris.org/"
SRC_URI="http://www.rapidsvn.org/download/${P}.tar.gz"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

DEPEND="=dev-util/subversion-0.37.0
	>=x11-libs/wxGTK-2.4.0
	doc? ( dev-libs/libxslt app-text/docbook-sgml-utils app-doc/doxygen )"

S=${WORKDIR}/${P}

src_compile() {
	# if you compiled subversion without (the) apache2 (flag) and with the berkdb flag
	# you will get an error that it can't find the lib db4
	local myconf
	#needs manpages support in docbook, gentoo doesn't seem to have this - i dunno
	use doc && myconf="--with-docbook-xsl=/usr/share/sgml/docbook/" \
		|| myconf="--without-xsltproc --without-docbook-xsl --without-doxygen \
			--without-dot"
	#README says you have too
	autoconf configure.in > configure
	econf	--with-svn-lib=/usr/lib \
		--with-svn-include=/usr/include \
		${myconf} || die "./configure failed"
	emake  || die
}

src_install() {
	einstall || die
}

