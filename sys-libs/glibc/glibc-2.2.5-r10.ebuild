# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/glibc/glibc-2.2.5-r10.ebuild,v 1.3 2005/08/25 18:22:39 azarah Exp $

inherit flag-o-matic eutils

PATCHVER=1.0
DESCRIPTION="GNU libc6 (also called glibc2) C library"
HOMEPAGE="http://www.gnu.org/software/libc/libc.html"
SRC_URI="ftp://sources.redhat.com/pub/glibc/releases/${P}.tar.bz2
	ftp://sources.redhat.com/pub/glibc/releases/glibc-linuxthreads-${PV}.tar.bz2
	mirror://gentoo/${P}-patches-${PATCHVER}.tar.bz2
	mirror://gentoo/${P}-manpages.tar.bz2"

LICENSE="LGPL-2"
SLOT="2.2"
KEYWORDS="x86 ppc sparc alpha"
IUSE="nls pic build"
RESTRICT="nostrip" # we'll handle stripping ourself #46186

DEPEND="virtual/os-headers
	nls? ( sys-devel/gettext )"
RDEPEND=""
PROVIDE="virtual/libc"

do_filter_flags() {
	# Over-zealous CFLAGS can often cause problems.  What may work for one
	# person may not work for another.  To avoid a large influx of bugs
	# relating to failed builds, we strip most CFLAGS out to ensure as few
	# problems as possible.
	strip-flags

	filter-flags -fomit-frame-pointer -malign-double

	# Sparc support
	replace-flags -mcpu=ultrasparc "-mcpu=v8 -mtune=ultrasparc"
	replace-flags -mcpu=v9 "-mcpu=v8 -mtune=v9"

	# Lock glibc at -O2 -- linuxthreads needs it and we want to be conservative here
	filter-flags -O?
	append-flags -O2
}

src_unpack() {
	unpack ${P}.tar.bz2 ${P}-patches-${PATCHVER}.tar.bz2
	cd "${S}"
	unpack ${P}-manpages.tar.bz2 glibc-linuxthreads-${PV}.tar.bz2
	epatch ${WORKDIR}/patch
	epatch ${FILESDIR}/2.3.3/glibc-2.3.3-localedef-fix-trampoline.patch
}

src_compile() {
	do_filter_flags
	rm -rf buildhere
	mkdir buildhere
	cd buildhere

	local myconf="\
		--with-gd=no \
		--without-cvs \
		--enable-add-ons=linuxthreads \
		--disable-profile \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--libexecdir=/usr/lib/misc"
	use nls || myconf="${myconf} --disable-nls"
	[[ -n ${CBUILD} ]] && myconf="${myconf} --build=${CBUILD}"
	[[ -n ${CTARGET} ]] && myconf="${myconf} --target=${CTARGET}"
	myconf="${myconf} ${EXTRA_ECONF}"
	echo ../configure ${myconf}
	../configure ${myconf} || die "configure failed"

	make PARALLELMFLAGS="${MAKEOPTS}" || die "make failed"
	src_test
}

src_test() {
	unset LD_PRELOAD
	make check || die "make check failed"
}

src_install() {
	export LC_ALL="C"
	make \
		PARALLELMFLAGS="${MAKEOPTS}" \
		install_root="${D}" \
		install -C buildhere \
		|| die "install failed"
	# now, strip everything but the thread libs #46186
	mkdir "${T}"/thread-backup
	mv "${D}"/lib/lib{pthread,thread_db}* "${T}"/thread-backup/
	env -uRESTRICT CHOST=${CTARGET} prepallstrip
	mv "${T}"/thread-backup/* "${D}"/lib/

	if ! use build ; then
		make \
			PARALLELMFLAGS="${MAKEOPTS}" \
			install_root="${D}" \
			localedata/install-locales -C buildhere \
			|| die "install locales failed"

		if ! has noinfo ${FEATURES} ; then
			make \
				PARALLELMFLAGS="${MAKEOPTS}" \
				install_root="${D}" \
				info -C buildhere \
				|| die "install info failed"
		fi
		if ! has noman ${FEATURES} ; then
			dodir /usr/share/man/man3
			doman "${S}"/man/*.3thr
		fi

		# Install nscd config file
		insinto /etc
		doins "${S}"/nscd/nscd.conf
		doinitd "${FILESDIR}"/nscd
		doins "${FILESDIR}"/nsswitch.conf

		dodoc BUGS ChangeLog* CONFORMANCE FAQ INTERFACE \
			NEWS NOTES PROJECTS README*
	else
		rm -r "${D}"/usr/share "${D}"/usr/lib/gconv
	fi

	if use pic ; then
		find "${S}"/buildhere -name "soinit.os" -exec cp {} "${D}"/lib/soinit.o \;
		find "${S}"/buildhere -name "sofini.os" -exec cp {} "${D}"/lib/sofini.o \;
		find "${S}"/buildhere -name "*_pic.a" -exec cp {} "${D}"/lib \;
		find "${S}"/buildhere -name "*.map" -exec cp {} "${D}"/lib \;
		for i in "${D}"/lib/*.map ; do
			mv "${i}" "${i%.map}"_pic.map
		done
	fi

	# Is this next line actually needed or does the makefile get it right?
	# It previously has 0755 perms which was killing things.
	fperms 4755 /usr/lib/misc/pt_chown

	rm -f "${D}"/etc/ld.so.cache

	# Prevent overwriting of the /etc/localtime symlink.  We'll handle the
	# creation of the "factory" symlink in pkg_postinst().
	rm -f "${D}"/etc/localtime

	# Some things want this, notably ash.
	dosym /usr/lib/libbsd-compat.a /usr/lib/libbsd.a
}

pkg_postinst() {
	if [[ ! -e ${ROOT}/etc/localtime ]] ; then
		echo "Please remember to set your timezone using the zic command."
		rm -f "${ROOT}"/etc/localtime
		ln -s ../usr/share/zoneinfo/Factory "${ROOT}"/etc/localtime
	fi
}
