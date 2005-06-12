# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sed/sed-4.1.4.ebuild,v 1.7 2005/06/12 17:58:25 j4rg0n Exp $

inherit flag-o-matic

DESCRIPTION="Super-useful stream editor"
HOMEPAGE="http://sed.sourceforge.net/"
SRC_URI="mirror://gnu/sed/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha arm amd64 hppa ia64 m68k mips ppc ppc64 ppc-macos s390 sh sparc x86"
IUSE="nls static build bootstrap"

RDEPEND=""
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_bootstrap_sed() {
	# make sure system-sed works #40786
	export NO_SYS_SED=""
	if ! use bootstrap && ! use build ; then
		if ! type -p sed ; then
			NO_SYS_SED="!!!"
			./bootstrap.sh || die "couldnt bootstrap"
			cp sed/sed ${T}/ || die "couldnt copy"
			export PATH="${PATH}:${T}"
		fi
	fi
}
src_bootstrap_cleanup() {
	if [[ -n ${NO_SYS_SED} ]] ; then
		make clean || die "couldnt clean"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-makeinfo-c-locale.patch
}

src_compile() {
	src_bootstrap_sed

	local myconf=""
	if use ppc-macos || use x86-fbsd ; then
		myconf="--program-prefix=g"
	fi
	econf \
		$(use_enable nls) \
		${myconf} \
		|| die "Configure failed"

	src_bootstrap_cleanup
	use static && append-ldflags -static
	emake LDFLAGS="${LDFLAGS}" || die "build failed"
}

src_install() {
	into /
	dobin sed/sed || die "dobin"
	if ! use build ; then
		make install DESTDIR="${D}" || die "Install failed"
		dodoc NEWS README* THANKS AUTHORS BUGS ChangeLog
		docinto examples
		dodoc "${FILESDIR}/dos2unix" "${FILESDIR}/unix2dos"
	else
		dodir /usr/bin
	fi

	rm -f "${D}"/usr/bin/sed
	if use ppc-macos || use x86-fbsd ; then
		cd "${D}"
		dosym /bin/gsed /usr/bin/gsed
		rm "${D}"/usr/lib/charset.alias "${D}"/usr/share/locale/locale.alias
	else
		dosym /bin/sed /usr/bin/sed
	fi
}
