# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/sqlite/sqlite-3.2.1-r1.ebuild,v 1.1 2005/04/02 20:11:34 arj Exp $

inherit eutils

IUSE="nothreadsafe"

DESCRIPTION="SQLite: An SQL Database Engine in a C Library."
SRC_URI="http://www.sqlite.org/${P}.tar.gz"
HOMEPAGE="http://www.sqlite.org"

# Adding glibc as dependency for USE !nothreadsafe until someone can tell me
#   if all virtual/libc's provide POSIX threads (pthread.h)
#   - 20041203, Armando Di Cianno <fafhrd@gentoo.org>
DEPEND="virtual/libc
	!nothreadsafe? ( !ppc-macos? ( sys-libs/glibc ) )
	dev-lang/tcl"
SLOT="3"
LICENSE="as-is"

KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc-macos ~sparc ~x86"

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
	myconf="--with-tcl=/usr/$(get_libdir)/"
	econf ${myconf} || die
	emake all || die # doc is not working yet in 3.1.2
}

# In case we ever want testing support; note: this needs more work, as
#   as it causes some sandbox issues.
#   - 20041203, Armando Di Cianno <fafhrd@gentoo.org>
#src_test() {
#	cd ${S}
#	emake fulltest || die "some test failed"
#}

src_install () {
	make DESTDIR="${D}" install || die

	dobin lemon
	dodoc README VERSION
	doman sqlite3.1
	docinto html
	dohtml doc/*.html doc/*.txt doc/*.png
}
