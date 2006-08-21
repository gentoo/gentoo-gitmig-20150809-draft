# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/newlib/newlib-1.14.0.ebuild,v 1.1 2006/08/21 03:06:20 lu_zero Exp $

inherit eutils flag-o-matic gnuconfig autotools

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
SRC_URI="ftp://sources.redhat.com/pub/newlib/${P}.tar.gz
		 mirror://gentoo/${P}-spu.patch.gz"

LICENSE="NEWLIB LIBGLOSS GPL-2"
[[ ${CTARGET} != ${CHOST} ]] \
	&& SLOT="${CTARGET}" \
	|| SLOT="0"
KEYWORDS="-* ~ppc64 ~ppc"
IUSE="nls threads unicode multilib"

DEPEND=">=sys-devel/gnuconfig"
RDEPEND=""

RESTRICT="nostrip"

NEWLIBBUILD="${WORKDIR}/build"

alt_build_kprefix() {
	if [[ ${CBUILD} == ${CHOST} && ${CTARGET} == ${CHOST} ]] \
	   || [[ -n ${UCLIBC_AND_GLIBC} ]]
	then
		echo /usr
	else
		echo /usr/${CTARGET}/usr
	fi
}

src_unpack() {
	unpack ${A}
	epatch ${WORKDIR}/${P}-spu.patch
	einfo "Updating configure scripts"
	cd ${S}
	gnuconfig_update
	export WANT_AUTOCONF=2.1
	# ugly workaround
	for a in libgloss libgloss/doc libgloss/libnosys
	do
		pushd ${S}/${a} >/dev/null
		aclocal 2>/dev/null
		autoconf 2>/dev/null
		popd >/dev/null
	done
	mkdir ${NEWLIBBUILD}
}

src_compile() {
	local myconf=""
#hardwired to avoid breakages
	[[ ${CTARGET} == *-softfloat-* ]] \
		&& myconf="--disable-newlib-hw-fp" \
		|| myconf="--enable-newlib-hw-fp"

#to the user discretion
	myconf="${myconf} `use_enable unicode newlib-mb`"
	myconf="${myconf} `use_enable nls`"
	myconf="${myconf} `use_enable multilib`"
	[[ ${CTARGET} == "spu" ]] \
		&& myconf="${myconf} --disable-threads" \
		|| myconf="${myconf} `use_enable threads`"

	cd ${NEWLIBBUILD}

	../${P}/configure \
		--host=${CHOST} \
		--target=${CTARGET} \
		--prefix=/usr \
		${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	cd ${NEWLIBBUILD}
	emake -j1 DESTDIR=${D} install
	env -uRESTRICT CHOST=${CTARGET} prepallstrip
	# minor hack to keep things clean
	rm -fR ${D}/usr/info
}
