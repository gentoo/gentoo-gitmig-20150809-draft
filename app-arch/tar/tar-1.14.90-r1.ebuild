# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/tar/tar-1.14.90-r1.ebuild,v 1.2 2004/11/03 15:48:16 lv Exp $

inherit flag-o-matic eutils gnuconfig

DESCRIPTION="Use this to make tarballs :)"
HOMEPAGE="http://www.gnu.org/software/tar/"
SRC_URI="http://dev.gentoo.org/~seemant/distfiles/${P}.tar.bz2
	http://alpha.gnu.org/gnu/tar/${P}.tar.bz2
	mirror://gnu/tar/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE="nls static build"

DEPEND="virtual/libc
	app-arch/gzip
	app-arch/bzip2
	app-arch/ncompress"
RDEPEND="${DEPEND}
	nls? ( >=sys-devel/gettext-0.10.35 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-remote-shell.patch #66959
	epatch ${FILESDIR}/${PV}-tests.patch #67023
	epatch ${FILESDIR}/${PV}-gnulib.patch #67038
	epatch ${FILESDIR}/${PV}-scripts.patch
	epatch ${FILESDIR}/${PV}-optimize.patch #69395
	gnuconfig_update
}

src_compile() {
	use static && append-ldflags -static
	# Work around bug in sandbox #67051
	gl_cv_func_chown_follows_symlink=yes \
	econf \
		--disable-dependency-tracking \
		--bindir=/bin \
		--libexecdir=/usr/sbin \
		$(use_enable nls) || die
	emake || die "emake failed"
}

src_test() {
	if [ "${ARCH}" == "x86" ] ; then
		einfo "Skipping make test due to a glibc bug (See #67051)."
		einfo "Then again, it probably would have worked anyways."
		einfo "So have some faith and pretend everything is OK."
	else
		make test || die "make test failed"
	fi
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	# a nasty yet required symlink:
	dodir /etc
	dosym ../usr/sbin/rmt /etc/rmt
	if use build ; then
		rm -rf ${D}/usr
	else
		dodoc AUTHORS ChangeLog* NEWS README* PORTS THANKS
		doman "${FILESDIR}/tar.1"
		mv ${D}/usr/sbin/backup{,-tar}
		mv ${D}/usr/sbin/restore{,-tar}
	fi
}
