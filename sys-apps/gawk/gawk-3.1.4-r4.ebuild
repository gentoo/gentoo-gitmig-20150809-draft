# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gawk/gawk-3.1.4-r4.ebuild,v 1.6 2005/08/07 23:53:05 vapier Exp $

inherit eutils toolchain-funcs

XML_PATCH=patch_3.1.4__xml_20040920
DESCRIPTION="GNU awk pattern-matching language"
HOMEPAGE="http://www.gnu.org/software/gawk/gawk.html"
SRC_URI="mirror://gnu/gawk/${P}.tar.gz
	xml? ( http://home1.vr-web.de/~Juergen.Kahrs/${XML_PATCH} )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="nls build xml"

RDEPEND="xml? ( dev-libs/expat )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

SXML=${WORKDIR}/xmlgawk
SFFS=${WORKDIR}/filefuncs

src_unpack() {
	unpack ${P}.tar.gz

	# Copy filefuncs module's source over ...
	cp -pPR "${FILESDIR}"/filefuncs "${SFFS}"/ || die "cp failed"

	cd "${S}"
	epatch "${FILESDIR}"/${P}-disable-DFA.patch #78227
	epatch "${FILESDIR}"/${PN}-3.1.3-getpgrp_void.patch #fedora
	epatch "${FILESDIR}"/${P}-nextc.patch #fedora
	epatch "${FILESDIR}"/${P}-uplow.patch #fedora
	# support for dec compiler.
	[[ $(tc-getCC) == "ccc" ]] && epatch "${FILESDIR}"/${PN}-3.1.2-dec-alpha-compiler.diff

	if use xml ; then
		mkdir "${SXML}"
		cp -pPR "${S}"/* "${SXML}"/
		cd "${SXML}"
		EPATCH_OPTS="-p2 -g0" epatch "${DISTDIR}"/${XML_PATCH} #57857
	fi

	cd "${S}"
	epatch "${FILESDIR}"/${P}-flonum.patch #fedora
}

src_compile() {
	econf \
		--bindir=/bin \
		$(use_enable nls) \
		--enable-switch \
		|| die
	emake || die "emake failed"
	if use xml ; then
		cd "${SXML}"
		econf $(use_enable nls) || die
		emake || die "xmlgawk make failed"
	fi

	cd "${SFFS}"
	emake AWKINCDIR="${S}" CC=$(tc-getCC) || die "filefuncs emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "install failed"
	if use xml ; then
		newbin "${SXML}"/gawk xmlgawk || die "xmlgawk failed"
		insinto /usr/include/awk
		doins "${SXML}"/xml_puller.h || die "xml inc failed"
	fi
	cd "${SFFS}"
	make \
		DESTDIR="${D}" \
		AWKINCDIR="${S}" \
		LIBDIR="$(get_libdir)" \
		install \
		|| die "filefuncs install failed"

	dodir /usr/bin
	# In some rare cases, (p)gawk gets installed as (p)gawk- and not
	# (p)gawk-${PV} ...  Also make sure that /bin/(p)gawk is a symlink
	# to /bin/(p)gawk-${PV}.
	local binpath x
	for x in gawk pgawk igawk ; do
		[[ ${x} == "gawk" ]] \
			&& binpath="/bin" \
			|| binpath="/usr/bin"

		if [[ -f ${D}/bin/${x} && ! -f ${D}/bin/${x}-${PV} ]] ; then
			mv -f "${D}"/bin/${x} "${D}"/${binpath}/${x}-${PV}
		elif [[ -f ${D}/bin/${x}- && ! -f ${D}/bin/${x}-${PV} ]] ; then
			mv -f "${D}"/bin/${x}- "${D}"/${binpath}/${x}-${PV}
		elif [[ ${binpath} == "/usr/bin" && -f ${D}/bin/${x}-${PV} ]] ; then
			mv -f "${D}"/bin/${x}-${PV} "${D}"/${binpath}/${x}-${PV}
		fi

		rm -f "${D}"/bin/${x}
		dosym ${x}-${PV} ${binpath}/${x}
		[[ ${binpath} == "/usr/bin" ]] && dosym /usr/bin/${x}-${PV} /bin/${x}
	done

	rm -f "${D}"/bin/awk
	dodir /usr/bin
	# Compat symlinks
	dosym /bin/gawk-${PV} /usr/bin/gawk
	dosym gawk-${PV} /bin/awk
	dosym /bin/gawk-${PV} /usr/bin/awk
	[[ ${USERLAND} != "GNU" ]] && rm -f "${D}"/{,usr/}bin/awk{,-${PV}}

	# Install headers
	insinto /usr/include/awk
	doins "${S}"/*.h || die "ins headers failed"
	# We do not want 'acconfig.h' in there ...
	rm -f "${D}"/usr/include/awk/acconfig.h

	if ! use build ; then
		cd "${S}"
		rm -f "${D}"/usr/share/man/man1/pgawk.1
		dosym gawk.1.gz /usr/share/man/man1/pgawk.1.gz
		[[ ${USERLAND} == "GNU" ]] && dosym gawk.1.gz /usr/share/man/man1/awk.1.gz
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
		rm -r "${D}"/usr/share
	fi
}
