# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bruce A. Locke <blocke@shivan.org>

S=${WORKDIR}/${P}
FILE_VERSION="ltrace_0.3.15"
DESCRIPTION="ltrace shows runtime library call information for dynamically linked executables"
SRC_URI="http://ftp.debian.org/debian/pool/main/l/ltrace/${FILE_VERSION}.tar.gz"
HOMEPAGE="http://packages.debian.org/unstable/utils/ltrace.html"

DEPEND="virtual/glibc"

src_compile() {

  try ./configure --prefix=/usr

  # pmake kept wanting to interpret ${CFLAGS} as params
  try make CFLAGS=\"${CFLAGS} -Wall\" all

}

src_install() {

  try make DESTDIR=${D} install

  # docs
  rm -rvf ${D}usr/doc/
  dodoc BUGS COPYING debian/changelog README TODO

}

