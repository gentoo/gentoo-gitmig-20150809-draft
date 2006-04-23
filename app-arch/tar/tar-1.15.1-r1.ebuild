# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/tar/tar-1.15.1-r1.ebuild,v 1.11 2006/04/23 16:43:28 kumba Exp $

inherit flag-o-matic eutils

DESCRIPTION="Use this to make tarballs :)"
HOMEPAGE="http://www.gnu.org/software/tar/"
SRC_URI="http://ftp.gnu.org/gnu/tar/${P}.tar.bz2
	http://alpha.gnu.org/gnu/tar/${P}.tar.bz2
	mirror://gnu/tar/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE="nls static build bzip2"

RDEPEND="app-arch/gzip
	bzip2? ( app-arch/bzip2 )"
DEPEND="${RDEPEND}
	nls? ( >=sys-devel/gettext-0.10.35 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-flex-arg.patch
	epatch "${FILESDIR}"/${P}-gcc4-test.patch #88214
	epatch "${FILESDIR}"/${P}-dont-abort-long-names.patch #87540
	epatch "${FILESDIR}"/${P}-less-verbose-newer.patch #86467
	epatch "${FILESDIR}"/${P}-lseek.patch
	epatch "${FILESDIR}"/${PN}-CVE-2006-0300.patch

	cp "${FILESDIR}"/append.at tests/

	if ! use userland_GNU ; then
		sed -i \
			-e 's:/backup\.sh:/gbackup.sh:' \
			scripts/{backup,dump-remind,restore}.in \
			|| die "sed non-GNU"
	fi
}

src_compile() {
	local myconf
	use static && append-ldflags -static
	use userland_GNU || myconf="--program-prefix=g"
	# Work around bug in sandbox #67051
	gl_cv_func_chown_follows_symlink=yes \
	econf \
		--enable-backup-scripts \
		--bindir=/bin \
		--libexecdir=/usr/sbin \
		$(use_enable nls) \
		${myconf} || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	# a nasty yet required symlink
	local p=""
	use userland_GNU || p=g
	dodir /etc
	dosym /usr/sbin/${p}rmt /etc/${p}rmt
	if use build ; then
		rm -r "${D}"/usr
	else
		dodir /usr/bin
		dosym /bin/${p}tar /usr/bin/${p}tar
		dodoc AUTHORS ChangeLog* NEWS README* PORTS THANKS
		newman "${FILESDIR}"/tar.1 ${p}tar.1
		mv "${D}"/usr/sbin/${p}backup{,-tar}
		mv "${D}"/usr/sbin/${p}restore{,-tar}
	fi

	rm -f ${D}/usr/$(get_libdir)/charset.alias
}
