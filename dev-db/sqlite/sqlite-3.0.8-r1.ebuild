# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/sqlite/sqlite-3.0.8-r1.ebuild,v 1.1 2004/12/04 18:18:16 fafhrd Exp $

IUSE="nls nothreadsafe"

S=${WORKDIR}/sqlite
DESCRIPTION="SQLite: An SQL Database Engine in a C Library."
SRC_URI="http://www.sqlite.org/${P}.tar.gz"
HOMEPAGE="http://www.sqlite.org"

# Adding glibc as dependency for USE !nothreadsafe until someone can tell me
#   if all virtual/libc's provide POSIX threads (pthread.h)
#   - 20041203, Armando Di Cianno <fafhrd@gentoo.org>
DEPEND="virtual/libc
	!nothreadsafe? ( sys-libs/glibc )
	dev-lang/tcl"
SLOT="3"
LICENSE="as-is"

KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"

src_compile() {
	# sqlite includes a doc directory making it impossible to generate docs, 
	# which are very important to people adding support for sqlite3 to their
	# programs.
	rm -rf doc/

	local myconf
	myconf="--enable-incore-db --enable-tempdb-in-ram"
	# Yes, this is ridiculous, but I'm not the maintainer for this ebuild,
	#   and yet it's broken w/o thread support, so this has to do for now
	#   - 20041203, Armando Di Cianno <fafhrd@gentoo.org>
	if ! use nothreadsafe; then
		myconf="${myconf} --enable-threadsafe"
	else
		myconf="${myconf} --disable-threadsafe"
	fi
	myconf="${myconf} `use_with nls utf8`"
	econf ${myconf} || die
	emake all doc || die
}

# In case we ever want testing support; note: this needs more work, as
#   as it causes some sandbox issues.
#   - 20041203, Armando Di Cianno <fafhrd@gentoo.org>
#src_test() {
#	cd ${S}
#	emake fulltest || die "some test failed"
#}

src_install () {
	dodir /usr/{bin,include,lib}

	einstall || die

	dobin lemon
	dodoc README VERSION
	doman sqlite.1
	docinto html
	dohtml doc/*.html doc/*.txt doc/*.png
}
