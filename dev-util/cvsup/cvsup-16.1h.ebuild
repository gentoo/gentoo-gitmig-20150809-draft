# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cvsup/cvsup-16.1h.ebuild,v 1.15 2007/03/31 21:13:35 robbat2 Exp $

inherit eutils

MY_P="${P/-/-snap-}"
DESCRIPTION="a faster alternative to cvs"
HOMEPAGE="http://www.cvsup.org/"
SRC_URI="ftp://ftp3.freebsd.org/pub/FreeBSD/development/CVSup/sources/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="-* x86 ppc"
IUSE="X doc static"

DEPEND="virtual/libc
	|| ( dev-util/yacc sys-devel/bison )
	>=sys-apps/sed-4
	virtual/m3"
RDEPEND="virtual/libc"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	[ ${ARCH} == "ppc" ] && epatch ${FILESDIR}/${PV}-ppc.patch
}

src_compile() {
	local mym3flags=""
	use static && mym3flags="${mym3flags} -DSTATIC"
	use X || mym3flags="${mym3flags} -DNOGUI"
	[ "${mym3flags:0:1}" == " " ] && mym3flags="${mym3flags:1}"
	sed -i \
		-e "s:/usr/local:${D}/usr:" \
	 	-e "s:^M3FLAGS=:M3FLAGS=${mym3flags}:" \
		Makefile || die "sed Makefile failed"

	# then we fix the /usr/local/etc/cvsup paths in all the files
	sed -i \
		-e "s:/usr/local/etc:/etc:" \
		`grep /usr/local/etc * -Rl` \
		|| die "sed ${f} failed"

	# then we compile cvsup
	make || die "cvsup compile failed"

	# now we do up the html pages ...
	if use doc ; then
		cd ${S}/doc
		make || die "html pages failed to compile !?"
		sed -i -e "s:images/::" *.html || die "sed ${f} failed"
		mv ${S}/doc/images/* ${S}/doc/
	fi
}

src_install() {
	dodir /var/cvsup

	for f in `find . -perm +1 -type f | grep -v doc` ; do
		dobin ${f} || die "dobin failed (${f})"
	done

	doman */src/*.[1-9] || die "doman failed"
	use doc && dohtml doc/*.{html,gif}
	dodoc Acknowledgments Announce Blurb ChangeLog Install

	insinto /etc/cvsup
	doins ${FILESDIR}/gentoo.sup ${FILESDIR}/gentoo_mirror.sup
	exeinto /etc/init.d
	newexe ${FILESDIR}/cvsupd.rc cvsupd || die "newexe failed"
	insinto /etc/conf.d
	newins ${FILESDIR}/cvsupd.confd cvsupd || die "newins failed"
}
