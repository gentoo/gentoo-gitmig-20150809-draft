# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/newlib/newlib-20061203.ebuild,v 1.1 2006/12/04 00:27:25 lu_zero Exp $

inherit eutils flag-o-matic

export CBUILD=${CBUILD:-${CHOST}}
export CTARGET=${CTARGET:-${CHOST}}
if [[ ${CTARGET} == ${CHOST} ]] ; then
		if [[ ${CATEGORY/cross-} != ${CATEGORY} ]] ; then
			export CTARGET=${CATEGORY/cross-}
		fi
fi

# Handle the case where we want newlib on glibc ...
if [[ ${CTARGET} == ${CHOST} ]] && [[ ${CHOST} != *-newlib ]] ; then
	export CTARGET=${CHOST%%-*}-pc-linux-newlib
fi

DESCRIPTION="Newlib is a C library intended for use on embedded systems"
HOMEPAGE="http://sourceware.org/newlib/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="NEWLIB LIBGLOSS GPL-2"
[[ ${CTARGET} != ${CHOST} ]] \
	&& SLOT="${CTARGET}" \
	|| SLOT="0"
KEYWORDS="-* ~ppc64 ~ppc"
IUSE="nls threads unicode multilib"
RESTRICT="strip"

DEPEND=""
RDEPEND=""

NEWLIBBUILD="${WORKDIR}/build"
S="${WORKDIR}/newlib"

src_unpack() {
	unpack ${A}
	mkdir -p "${NEWLIBBUILD}"
}

src_compile() {
	# we should fix this ...
	unset LDFLAGS
	CHOST=${CTARGET} strip-unsupported-flags

	local myconf=""
	# hardwired to avoid breakages
	[[ ${CTARGET} == *-softfloat-* ]] \
		&& myconf="--disable-newlib-hw-fp" \
		|| myconf="--enable-newlib-hw-fp"
	[[ ${CTARGET} == "spu" ]] \
		&& myconf="${myconf} --disable-threads" \
		|| myconf="${myconf} $(use_enable threads)"

	cd "${NEWLIBBUILD}"

	ECONF_SOURCE=${S} \
	econf \
		$(use_enable unicode newlib-mb) \
		$(use_enable nls) \
		$(use_enable multilib) \
		${myconf} \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	cd "${NEWLIBBUILD}"
	emake -j1 DESTDIR="${D}" install
	env -uRESTRICT CHOST=${CTARGET} prepallstrip
	# minor hack to keep things clean
	rm -fR "${D}"/usr/info
}
