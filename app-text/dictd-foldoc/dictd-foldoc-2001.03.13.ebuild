# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Michael Conrad Tilstra <michael@gentoo.org> <tadpol@tadpol.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/dictd-foldoc/dictd-foldoc-2001.03.13.ebuild,v 1.1 2001/04/24 22:07:29 michael Exp $

#P=
A=foldoc-20010313.tar.gz
S=${WORKDIR}
DESCRIPTION=""
SRC_URI="ftp://ftp.dict.org/pub/dict/pre/${A}"
HOMEPAGE="http://www.dict.org"

DEPEND=">=app-text/dictd-1.5.5"

src_install () {
	dodir /usr/lib/dict
	insinto /usr/lib/dict
	doins foldoc.dict.dz
	doins foldoc.index
}

pkg_postinst() {
if [ -f /etc/dict/dictd.conf ]; then
cat >> /etc/dict/dictd.conf << __EOF__
database foldoc { data "/usr/lib/dict/foldoc.dict.dz"
                  index "/usr/lib/dict/foldoc.index" }
__EOF__
fi
}


# vim: ai et sw=4 ts=4
