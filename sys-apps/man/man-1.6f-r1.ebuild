# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/man/man-1.6f-r1.ebuild,v 1.4 2008/04/24 19:30:27 jer Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Standard commands to read man pages"
HOMEPAGE="http://primates.ximian.com/~flucifredi/man/"
SRC_URI="http://primates.ximian.com/~flucifredi/man/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ~arm hppa ~ia64 ~m68k ~mips ~ppc ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE="nls"

DEPEND="nls? ( sys-devel/gettext )"
RDEPEND=">=sys-apps/groff-1.19.2-r1
	!sys-apps/man-db
	!app-arch/lzma"
PROVIDE="virtual/man"

pkg_setup() {
	enewgroup man 15
	enewuser man 13 -1 /usr/share/man man
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/man-1.6f-man2html-compression.patch
	epatch "${FILESDIR}"/man-1.6-cross-compile.patch
	epatch "${FILESDIR}"/man-1.5p-search-order.patch
	epatch "${FILESDIR}"/man-1.6f-unicode.patch #146315
	epatch "${FILESDIR}"/man-1.5p-defmanpath-symlinks.patch
	epatch "${FILESDIR}"/man-1.6b-more-sections.patch
	epatch "${FILESDIR}"/man-1.6c-cut-duplicate-manpaths.patch
	epatch "${FILESDIR}"/man-1.5m2-apropos.patch
	epatch "${FILESDIR}"/man-1.6d-fbsd.patch
	epatch "${FILESDIR}"/man-1.6e-headers.patch

	strip-linguas $(eval $(grep ^LANGUAGES= configure) ; echo ${LANGUAGES//,/ })
}

src_compile() {
	unset NLSPATH #175258

	tc-export CC BUILD_CC

	local mylang=
	if use nls ; then
		if [[ -z ${LINGUAS} ]] ; then
			mylang="all"
		else
			mylang="${LINGUAS// /,}"
		fi
	else
		mylang="none"
	fi
	./configure \
		-confdir=/etc \
		+sgid +fhs \
		+lang ${mylang} \
		|| die "configure failed"

	emake || die "emake failed"
}

src_install() {
	unset NLSPATH #175258

	emake PREFIX="${D}" install || die "make install failed"
	dosym man /usr/bin/manpath

	dodoc LSM README* TODO

	# makewhatis only adds man-pages from the last 24hrs
	exeinto /etc/cron.daily
	newexe "${FILESDIR}"/makewhatis.cron makewhatis

	keepdir /var/cache/man
	diropts -m0775 -g man
	local mansects=$(grep ^MANSECT "${D}"/etc/man.conf | cut -f2-)
	for x in ${mansects//:/ } ; do
		keepdir /var/cache/man/cat${x}
	done
}

pkg_postinst() {
	einfo "Forcing sane permissions onto ${ROOT}/var/cache/man (Bug #40322)"
	chown -R root:man "${ROOT}"/var/cache/man
	chmod -R g+w "${ROOT}"/var/cache/man
	[[ -e ${ROOT}/var/cache/man/whatis ]] \
		&& chown root:0 "${ROOT}"/var/cache/man/whatis

	echo

	local f files=$(ls "${ROOT}"/etc/cron.{daily,weekly}/makewhatis{,.cron} 2>/dev/null)
	for f in ${files} ; do
		[[ ${f} == */etc/cron.daily/makewhatis ]] && continue
		[[ $(md5sum "${f}") == "8b2016cc778ed4e2570b912c0f420266 "* ]] \
			&& rm -f "${f}"
	done
	files=$(ls "${ROOT}"/etc/cron.{daily,weekly}/makewhatis{,.cron} 2>/dev/null)
	if [[ ${files/$'\n'} != ${files} ]] ; then
		ewarn "You have multiple makewhatis cron files installed."
		ewarn "You might want to delete all but one of these:"
		ewarn ${files}
	fi
}
