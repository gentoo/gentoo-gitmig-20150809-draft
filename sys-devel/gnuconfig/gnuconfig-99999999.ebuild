# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gnuconfig/gnuconfig-99999999.ebuild,v 1.1 2008/01/30 01:38:23 vapier Exp $

EGIT_REPO_URI="git://git.savannah.gnu.org/config.git"
inherit eutils git

DESCRIPTION="Updated config.sub and config.guess file from GNU"
HOMEPAGE="http://savannah.gnu.org/projects/config"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

S=${WORKDIR}

maint_pkg_create() {
	cd "${S}"

	local ver=$(head -n 1 ChangeLog | awk '{print $1}' | sed -e 's:-::g')
	[[ ${#ver} != 8 ]] && die "invalid version '${ver}'"

	cp "${FILESDIR}"/${PV}/*.patch . || die

	local tar="${T}/gnuconfig-${ver}.tar.bz2"
	tar -jcf ${tar} . || die "creating tar failed"
	einfo "Packaged tar now available:"
	einfo "$(du -b ${tar})"

	epatch *.patch
}

src_unpack() {
	git_src_unpack
	maint_pkg_create
}

src_compile() { :;}

src_install() {
	insinto /usr/share/${PN}
	doins config.{sub,guess} || die
	fperms +x /usr/share/${PN}/config.{sub,guess}
	dodoc ChangeLog
}
