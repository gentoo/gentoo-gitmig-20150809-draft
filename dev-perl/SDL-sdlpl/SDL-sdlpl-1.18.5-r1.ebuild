# Copyright 2002 Gentoo Technologies, Inc.
# distributed under the terms of the GNU General Pulic License, v2.
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SDL-sdlpl/SDL-sdlpl-1.18.5-r1.ebuild,v 1.2 2002/06/24 12:11:47 seemant Exp $


RDEPEND="dev-perl/sdl-perl"

pkg_postinst() {

	einfo
	einfo "This package has been moved to dev-perl/sdl-perl instead"
	einfo "and sdl-perl has been installed on your system as part of this"
	einfo "emerge.  Please run: emerge unmerge SDL-sdlpl"
	einfo
}
