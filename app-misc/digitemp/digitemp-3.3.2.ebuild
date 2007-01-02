# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/digitemp/digitemp-3.3.2.ebuild,v 1.5 2007/01/02 23:42:03 masterdriverz Exp $

DESCRIPTION="Temperature logging and reporting using Dallas Semiconductor's iButtons and 1-Wire protocol"
HOMEPAGE="http://www.digitemp.com http://www.ibutton.com"
SRC_URI="http://www.digitemp.com/software/linux/${P}.tar.gz"

IUSE="ds9097 ds9097u ds2490"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="ds2490? ( >=dev-libs/libusb-0.1.10a )"

targets() {
	# default is to compile to the ds9097u.
	if ! ( use ds9097 || use ds9097u || use ds2490 ); then
		echo ds9097u
	fi
	for target in ds9097 ds9097u ds2490; do
		if use ${target}; then
			echo ${target}
		fi
	done
}

src_compile() {
	# default is to compile to the ds9097u.
	if ! ( use ds9097 || use ds9097u || use ds2490 ); then
		ewarn "If you don't choose a component to install, we default to ds9097u"
	fi

	local targets=$(targets)

	for target in $targets; do
		emake clean
		emake LOCK="no" ${target} || die "emake ${target} failed"
	done
}

src_install() {
	for target in $(echo $(targets) | tr '[:lower:]' '[:upper:]'); do
		dobin digitemp_${target} && \
		dosym digitemp_${target} /usr/bin/digitemp
	done

	if [[ $($(targets)|wc -l) -ge 1 ]]; then
		echo
		ewarn "/usr/bin/digitemp has been symlinked to /usr/bin/digitemp_${target}"
		ewarn "If you want to access the others, they are available at /usr/bin/digitemp_*"
		echo
	fi

	dodoc README FAQ TODO

	for example in perl python rrdb; do
		insinto "/usr/share/doc/${PF}/${example}_examples"
		doins ${example}/*
	done
}

pkg_postinst() {
	echo
	einfo "Examples of using digitemp with python, perl, and rrdtool are"
	einfo "located in /usr/share/doc/${PF}/"
	echo
}
