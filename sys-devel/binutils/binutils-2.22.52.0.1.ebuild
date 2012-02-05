# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils/binutils-2.22.52.0.1.ebuild,v 1.1 2012/02/05 02:57:52 vapier Exp $

PATCHVER="1.0"
ELF2FLT_VER=""
inherit toolchain-binutils

# 66_all_binutils-2.22-warn-textrel.patch fails to apply with
# patch-2.5.9, so require a version that for sure works
DEPEND+=" >=sys-devel/patch-2.6.1"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 -sparc-fbsd -x86-fbsd"
