# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/opendx-samples/opendx-samples-4.3.2.ebuild,v 1.7 2010/01/18 05:57:43 bicatali Exp $

S="${WORKDIR}/dxsamples-${PV}"

DESCRIPTION="Samples for IBM Data Explorer"
HOMEPAGE="http://www.opendx.org/"
SRC_URI="http://opendx.npaci.edu/source/dxsamples-${PV}.tar.gz"
LICENSE="IBM"
SLOT="0"

KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="=sci-visualization/opendx-${PV}*"

# this einstall do not define datadir, because
# it will cause problems since datadir is redefined
# across Makefiles
my_einstall() {
	if [ -f ./[mM]akefile -o -f ./GNUmakefile ] ; then
		if [ ! -z "${PORTAGE_DEBUG}" ]; then
			make -n prefix=${D}/usr \
				infodir=${D}/usr/share/info \
				localstatedir=${D}/var/lib \
				mandir=${D}/usr/share/man \
				sysconfdir=${D}/etc \
				"$@" install
		fi
		make prefix=${D}/usr \
			infodir=${D}/usr/share/info \
			localstatedir=${D}/var/lib \
			mandir=${D}/usr/share/man \
			sysconfdir=${D}/etc \
			"$@" install || die "einstall failed"
	else
		die "no Makefile found"
	fi
}

src_install() {
	my_einstall || die
}
