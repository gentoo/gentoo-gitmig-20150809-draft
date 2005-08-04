# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/clearsilver/clearsilver-0.9.14-r1.ebuild,v 1.1 2005/08/04 21:10:21 herbs Exp $

# Please note: apache, java, mono and ruby support disabled for now.
# Fill a bug if you need it.
#
# dju@gentoo.org, 4th July 2005

inherit eutils python

DESCRIPTION="Clearsilver is a fast, powerful, and language-neutral HTML template system."
HOMEPAGE="http://www.clearsilver.net/"
SRC_URI="http://www.clearsilver.net/downloads/${P}.tar.gz"

LICENSE="CS-1.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="perl python zlib"

# Important:
#
# We don't redistribute clearsilver - we just provide a way to install it
# By doing this, I believe we are compliant with the license without any
# further actions.
#
# stuart@gentoo.org, 25th April 2004

RESTRICT="nomirror"

DEPEND="python? ( dev-lang/python )
	perl? ( dev-lang/perl )
	zlib? ( sys-libs/zlib )"
#	ruby? ( dev-lang/ruby )
#	java? ( virtual/jdk )

DOCS="README INSTALL"

if use python ; then
	DOCS="${DOCS} README.python"
fi

src_unpack () {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-python24.patch
	epatch ${FILESDIR}/${P}-fPIC.patch
	sed -i s,bin/httpd,bin/apache,g configure || die "sed failed"
}

src_compile() {
#	local jdkhome=`java-config -O`
#	use java && myconf="${myconf} --with-java=${jdkhome}" \

	econf \
		$(use_enable perl) \
		$(use_enable python) \
		$(use_enable zlib compression) \
		"--disable-apache" \
		"--disable-ruby" \
		"--disable-java" \
		"--disable-csharp" \
		|| die "./configure failed"

	emake || die "make failed"
}

src_install () {
	cd ${S}
	sed -i s,/usr/local,/usr, scripts/document.py
	python_version
	sed -i s,/usr/lib/portage/pym,/usr/lib/python${PYVER}/site-packages, rules.mk
	make DESTDIR=${D} install || die "make install failed"

	dodoc ${DOCS}
}
