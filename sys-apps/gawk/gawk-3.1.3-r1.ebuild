# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gawk/gawk-3.1.3-r1.ebuild,v 1.21 2004/11/12 14:29:15 vapier Exp $

inherit eutils gnuconfig toolchain-funcs

DESCRIPTION="GNU awk pattern-matching language"
HOMEPAGE="http://www.gnu.org/software/gawk/gawk.html"
SRC_URI="mirror://gnu/gawk/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86"
IUSE="nls build uclibc"

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}

	# Copy filefuncs module's source over ...
	cp -dR "${FILESDIR}/filefuncs" "${WORKDIR}/" || die "cp failed"

	cd ${S}
	# support for dec compiler.
	[ "${CC}" == "ccc" ] && epatch ${FILESDIR}/${PN}-3.1.2-dec-alpha-compiler.diff
	epatch ${FILESDIR}/64bitnumfile.patch

	gnuconfig_update
}

src_compile() {
	local myconf=
	use nls || myconf="${myconf} --disable-nls"
	[ -z "${CBUILD}" ] || myconf="${myconf} --build=${CBUILD}"
	./configure \
		--prefix=/usr \
		--libexecdir=/usr/$(get_libdir)/awk \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--host=${CHOST} \
		${myconf} \
		|| die

	emake || die "emake failed"

	cd ${WORKDIR}/filefuncs
	emake AWKINCDIR=${S} CC=$(tc-getCC) || die "filefuncs emake failed"
}

src_install() {
	local x=

	make \
		prefix=${D}/usr \
		bindir=${D}/bin \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		libexecdir=${D}/usr/$(get_libdir)/awk \
		install || die "install failed"

	cd ${WORKDIR}/filefuncs
	make \
		DESTDIR=${D} \
		AWKINCDIR=${S} \
		install || die "filefuncs install failed"

	dodir /usr/bin
	# In some rare cases, (p)gawk gets installed as (p)gawk- and not
	# (p)gawk-${PV} ..  Also make sure that /bin/(p)gawk is a symlink
	# to /bin/(p)gawk-${PV}.
	for x in gawk pgawk igawk
	do
		local binpath="/bin"

		case ${x} in
		igawk|pgawk)
				binpath="/usr/bin"
				;;
		esac

		if [ -f "${D}/bin/${x}" -a ! -f "${D}/bin/${x}-${PV}" ]
		then
			mv -f ${D}/bin/${x} ${D}/${binpath}/${x}-${PV}
		elif [ -f "${D}/bin/${x}-" -a ! -f "${D}/bin/${x}-${PV}" ]
		then
			mv -f ${D}/bin/${x}- ${D}/${binpath}/${x}-${PV}
		elif [ "${binpath}" = "/usr/bin" -a -f "${D}/bin/${x}-${PV}" ]
		then
			mv -f ${D}/bin/${x}-${PV} ${D}/${binpath}/${x}-${PV}
		fi

		rm -f ${D}/bin/${x}
		dosym ${x}-${PV} ${binpath}/${x}
		[ "${binpath}" = "/usr/bin" ] && dosym ../usr/bin/${x}-${PV} /bin/${x}
	done

	rm -f ${D}/bin/awk
	dosym gawk-${PV} /bin/awk
	# Compat symlinks
	dodir /usr/bin
	dosym ../../bin/gawk-${PV} /usr/bin/awk
	dosym ../../bin/gawk-${PV} /usr/bin/gawk

	# Install headers
	insinto /usr/include/awk
	for x in ${S}/*.h
	do
		# We do not want 'acconfig.h' in there ...
		if [ -f "${x}" -a "${x/acconfig\.h/}" = "${x}" ]
		then
			doins ${x}
		fi
	done

	if ! use build
	then
		cd ${S}
		dosym gawk.1.gz /usr/share/man/man1/awk.1.gz
		dodoc AUTHORS ChangeLog FUTURES LIMITATIONS NEWS PROBLEMS POSIX.STD README
		docinto README_d
		dodoc README_d/*
		docinto awklib
		dodoc awklib/ChangeLog
		docinto pc
		dodoc pc/ChangeLog
		docinto posix
		dodoc posix/ChangeLog
	else
		rm -rf ${D}/usr/share
	fi
}
