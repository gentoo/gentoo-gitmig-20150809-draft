# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pcmcia-cs-pnptools/pcmcia-cs-pnptools-3.2.8.ebuild,v 1.2 2006/02/13 15:37:55 brix Exp $

inherit eutils toolchain-funcs linux-info

MY_P=${P/-pnptools/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="PCMCIA PNP tools for Linux"
HOMEPAGE="http://pcmcia-cs.sourceforge.net"
SRC_URI="mirror://sourceforge/pcmcia-cs/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

IUSE=""
RDEPEND="!sys-apps/pcmcia-cs"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${MY_P}-move-pnp-ids.patch
	epatch ${FILESDIR}/${MY_P}-gcc4.patch
}

pcmcia_cs_configure() {
	# output arguments to Configure to assist in debugging
	echo "${S}/Configure $@"
	${S}/Configure "$@" || die "Configure failed"
	return ${?}
}

src_compile() {
	pcmcia_cs_configure \
		--noprompt \
		--kernel=${KV_DIR} \
		--target=${D} \
		--arch=$(tc-arch-kernel) \
		--ucc=$(tc-getCC) \
		--kcc=$(tc-getCC) \
		--ld=$(tc-getLD) \
		--uflags="${CFLAGS}" \
		--kflags="$(getfilevar HOSTCFLAGS ${KV_DIR}/Makefile)" \
		--srctree \
		--nox11 \
		--pnp \
		|| die "Configure failed"

	emake all || die "emake failed"
}

src_install () {
	dosbin debug-tools/lspnp debug-tools/setpnp

	insinto /usr/share/misc
	doins debug-tools/pnp.ids

	doman man/lspnp.8 man/setpnp.8
}
