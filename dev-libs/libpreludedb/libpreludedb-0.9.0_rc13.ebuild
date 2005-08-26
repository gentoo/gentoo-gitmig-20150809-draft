# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libpreludedb/libpreludedb-0.9.0_rc13.ebuild,v 1.1 2005/08/26 21:53:53 vanquirius Exp $

inherit versionator

MY_P="${PN}-$(replace_version_separator 3 '-')"
DESCRIPTION="Prelude-IDS framework for easy access to the Prelude database"
HOMEPAGE="http://www.prelude-ids.org/"
SRC_URI="http://www.prelude-ids.org/download/releases/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86"
IUSE="debug doc mysql postgres perl python"

DEPEND="virtual/libc
	>=dev-libs/libprelude-0.9.0_rc14
	doc? ( dev-util/gtk-doc )
	mysql? ( dev-db/mysql )
	postgres? ( dev-db/postgresql )"

S="${WORKDIR}/${MY_P}"

src_compile() {
	local myconf

	use debug && append-flags -O -ggdb
	use doc && myconf="${myconf} --enable-gtk-doc" || myconf="${myconf} --enable-gtk-doc=no"
	use mysql && myconf="${myconf} --enable-mysql" || myconf="${myconf} --enable-mysql=no"
	use postgres && myconf="${myconf} --enable-postgresql" || myconf="${myconf} --enable-postgresql=no"
	use perl && myconf="${myconf} --enable-perl" || myconf="${myconf} --enable-perl=no"
	use python && myconf="${myconf} --enable-python" || myconf="${myconf} --enable-python=no"
	econf ${myconf} || die "econf failed"

	emake -j1 || die "emake failed"
	# -j1 may not be necessary in the future
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	# prevent file collision
	rm ${D}/usr/lib/perl5/5.8.6/i686-linux/perllocal.pod
}

pkg_postinst() {
	einfo "For additional installation instructions go to"
	einfo "https://trac.prelude-ids.org/wiki/InstallingLibpreludedb"
}
