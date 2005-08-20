# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/opendx-samples/opendx-samples-4.3.2.ebuild,v 1.2 2005/08/20 07:54:02 hansmi Exp $

S="${WORKDIR}/dxsamples-${PV}"

DESCRIPTION="Samples for IBM Data Explorer"
HOMEPAGE="http://www.opendx.org/"
SRC_URI="http://opendx.npaci.edu/source/dxsamples-${PV}.tar.gz"
LICENSE="IPL-1"
SLOT="0"

KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND="=media-gfx/opendx-${PV}*"

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

