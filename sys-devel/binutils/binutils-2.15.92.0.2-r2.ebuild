# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils/binutils-2.15.92.0.2-r2.ebuild,v 1.4 2004/11/07 09:14:33 mr_bones_ Exp $

inherit eutils libtool flag-o-matic gnuconfig

PATCHVER="1.2"
UCLIBC_PATCHVER="1.0"
DESCRIPTION="Tools necessary to build programs"
HOMEPAGE="http://sources.redhat.com/binutils/"
SRC_URI="mirror://kernel/linux/devel/binutils/${P}.tar.bz2
	mirror://kernel/linux/devel/binutils/test/${P}.tar.bz2
	mirror://gentoo/${PN}-${PV:0:4}-uclibc-patches-${UCLIBC_PATCHVER}.tar.bz2
	mirror://gentoo/${P}-patches-${PATCHVER}.tar.bz2"

LICENSE="|| ( GPL-2 LGPL-2 )"
SLOT="${CTARGET:-${CHOST}}"
KEYWORDS="-*"
IUSE="nls bootstrap build multitarget uclibc"

DEPEND="virtual/libc
	nls? ( sys-devel/gettext )
	!build? ( !bootstrap? ( dev-lang/perl ) )"

MY_BUILDDIR="${WORKDIR}/build"

src_unpack() {
	unpack ${A}
	cd ${S}
	mkdir -p "${MY_BUILDDIR}"

	# Patches
	cd ${WORKDIR}/patch
	mkdir skip
	if use uclibc ; then
		mv *relro* skip/
	else
		mv *no_rel_ro* 20_* skip/
	fi
	mv *ldsoconf* skip/
	cd ${S}
	epatch ${WORKDIR}/patch
	epatch ${WORKDIR}/uclibc-patches

	# Run misc portage update scripts
	gnuconfig_update
	elibtoolize --portage --no-uclibc

	strip-linguas -i */po
}

src_compile() {
	strip-linguas -i */po #42033

	filter-flags -fomit-frame-pointer -fssa #6730
	strip-flags && replace-flags -O3 -O2 #47581

	cd "${MY_BUILDDIR}"
	local myconf=""
	use nls \
		&& myconf="${myconf} --without-included-gettext" \
		|| myconf="${myconf} --disable-nls"
	use multitarget && myconf="${myconf} --enable-targets=all"
	ECONF_SOURCE="${S}" \
	econf \
		--enable-shared \
		--enable-64-bit-bfd \
		${myconf} || die

	make configure-bfd || die "configure-bfd"
	make headers -C bfd || die "headers-bfd"
	emake all || die "emake"

	if ! use build ; then
		if ! has noinfo ${FEATURES} ; then
			# Make the info pages (makeinfo included with gcc is used)
			make info || die "info"
		fi
		if ! use bootstrap && ! has noman ${FEATURES} ; then
			cd "${S}"
			# Nuke the manpages to recreate them (only use this if we have perl)
			find . -name '*.1' -exec rm -f {} \; || :
		fi
	fi
}

src_test() {
	emake check
}

src_install() {
	local x d

	cd "${MY_BUILDDIR}"
	make DESTDIR="${D}" install || die

	# Now we move everything out of /usr and into $CTARGET/$SLOT
	if [ -n "${CTARGET}" ] && [ "${CHOST}" != "${CTARGET}" ] ; then
		cd "${D}/usr/${CHOST}/${CTARGET}/"
		for x in * ; do
			cp -r ${x} ../../${CTARGET}/
			rm -r ${x}
			ln -s ../../${CTARGET}/${x}
		done

		cd "${D}/usr/bin"
		for x in * ; do
			[ "${x/${CTARGET}}" != "${x}" ] && mv "${x}" "${x/${CTARGET}-}"
		done

		rm -rf "${D}"/usr/share/{locale,doc,man,info}

		dodir /usr/include
	else
		insinto /usr/include
		doins "${S}/include/libiberty.h"
	fi
	cd "${D}/usr"
	find bin -maxdepth 1 -type l -exec rm {} \;
	cp -r bin lib include ${SLOT}/
	rm -r bin lib include

	# Keep all the real files in /usr/${SLOT}/ and symlink 
	# them into our path for
	cd "${D}/usr/${SLOT}/bin"
	dodir /usr/bin
	for x in * ; do
		dosym ../${SLOT}/bin/${x} /usr/bin/${SLOT}-${x}
	done
	if [ -z "${CTARGET}" ] || [ "${CHOST}" == "${CTARGET}" ] ; then
		for d in bin lib include ; do
			cd "${D}/usr/${SLOT}/${d}"
			dodir /usr/${d}
			for x in * ; do
				[ -d "${x}" ] && continue
				dosym ../${SLOT}/${d}/${x} /usr/${d}/${x}
			done
		done

		if [ -n "${PROFILE_ARCH}" ] && [ "${PROFILE_ARCH/64}" != "${PROFILE_ARCH}" ] ; then
			dosym ${CHOST} /usr/${CHOST/-/64-}
			for x in `ls ${D}/usr/${CHOST}/bin/` ; do
				[ ! -e "${D}/usr/bin/${CHOST}-${x}" ] && \
					dosym ../${CHOST}/bin/${x} /usr/bin/${CHOST}-${x}
				dosym ../${CHOST}/bin/${x} /usr/bin/${CHOST/-/64-}-${x}
			done
		fi
	fi

	# Handle documentation
	if ! use build ; then
		if ! has noinfo ${FEATURES} ; then
			cd "${MY_BUILDDIR}"
			make DESTDIR="${D}" install-info || die
		fi

		if ! has nodoc ${FEATURES} ; then
			cd "${S}"
			dodoc README
			docinto bfd
			dodoc bfd/ChangeLog* bfd/README bfd/PORTING bfd/TODO
			docinto binutils
			dodoc binutils/ChangeLog binutils/NEWS binutils/README
			docinto gas
			dodoc gas/ChangeLog* gas/CONTRIBUTORS gas/NEWS gas/README*
			docinto gprof
			dodoc gprof/ChangeLog* gprof/TEST gprof/TODO gprof/bbconv.pl
			docinto ld
			dodoc ld/ChangeLog* ld/README ld/NEWS ld/TODO
			docinto libiberty
			dodoc libiberty/ChangeLog* libiberty/README
			docinto opcodes
			dodoc opcodes/ChangeLog*
			# Install pre-generated manpages .. currently we do not ...
		fi
	else
		rm -rf ${D}/usr/share/man
	fi
}
