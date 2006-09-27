# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/clearsilver/clearsilver-0.10.3.ebuild,v 1.1 2006/09/27 22:10:30 dju Exp $

# Please note: apache, java, mono and ruby support disabled for now.
# Fill a bug if you need it.
#
# dju@gentoo.org, 4th July 2005

inherit eutils perl-app

DESCRIPTION="Clearsilver is a fast, powerful, and language-neutral HTML template system."
HOMEPAGE="http://www.clearsilver.net/"
SRC_URI="http://www.clearsilver.net/downloads/${P}.tar.gz"

LICENSE="CS-1.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="perl python zlib"

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

	# rename static.cgi to something more sensible
	epatch ${FILESDIR}/${PV}-static.cgi.patch
	# fix for bug #146026
	epatch ${FILESDIR}/${PV}-missing-csr.patch
	# fix for bug #148863
	use python && epatch ${FILESDIR}/${PV}-PyObject_DEL.patch
}

src_compile() {
	econf \
		$(use_enable perl) \
		$(use_with perl perl /usr/bin/perl) \
		$(use_enable python) \
		$(use_with python python /usr/bin/python) \
		$(use_enable zlib compression) \
		"--disable-apache" \
		"--disable-ruby" \
		"--disable-java" \
		"--disable-csharp" \
		|| die "./configure failed"

	emake || die "emake failed"
}

src_install () {
	cd ${S}

	make DESTDIR=${D} install || die "make install failed"

	dodoc ${DOCS} || die "dodoc failed"

	if use perl ; then
		fixlocalpod || die "fixlocalpod failed"
	fi
}
