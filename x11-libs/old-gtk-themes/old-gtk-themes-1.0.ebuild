# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Aron Griffis <agriffis@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-libs/old-gtk-themes/old-gtk-themes-1.0.ebuild,v 1.3 2002/05/23 06:50:19 seemant Exp $

S=${WORKDIR}
DESCRIPTION="All themes from (new) gtk.themes.org"
HOMEPAGE="http://www.themes.org/skins/gtk/"
SRC_URI=""

DEPEND="=x11-libs/gtk+-1.2*
		>=x11-libs/gtk-engines-0.12-r2
		>=x11-libs/gtk-thinice-theme-1.0.4-r1
		>=net-ftp/ncftp-3.0.3
		>=net-misc/wget-1.7-r2"

src_unpack() {
	local f a
	# Get the directory listing; this creates the file .listing
	rm -f .listing
	wget -nr -O/dev/null --passive-ftp \
		http://www.themes.org/skins/gtk/ \
		|| die "wget failed"
	# Convert it from "ls -l" format to "ls" format, and remove
	# carriage returns.  Skip LCARS_blue-1.2, which appears to be
	# a corrupt archive.
	sed 's/.$//' .listing | \
		awk '$9~/^LCARS_blue-1.2/ { next }
			 /tar.gz$/ {
				for (i=9;i<NF;i++) printf "%s ", $i;
				print $NF;
			 }' > listing
	# Get all the themes.  Use ncftpget so that it checks times and
	# only overwrites if appropriate.
	einfo "Please wait a minute while I fetch the themes, if necessary"
	cd ${DISTDIR}
	ncftpget ftp://ftp3.sourceforge.net/pub/mirrors/themes.org/gtk/*.tar.gz
	if [ $? != 3 -a $? != 0 ]; then
		die "ncftpget failed"
	fi
	cd ${S}
	# Unpack the themes "intelligently", so that older themes don't
	# overwrite newer themes.
	#   (1) Unpack each theme into its own temporary numbered
	#       directory.
	#   (2) Skip known problematic or duplicated themes.  Note that we
	#       have to skip these here, not above, because the directory
	#       names are often quite different from the tarfiles.
	#       - Xenophilia is both duplicated and problematic.  It tries
	#         to install to locations directly, ignoring both prefix=
	#         and DESTDIR=
	#       - ThinIce is duplicated in x11-libs/gtk-thinice-theme-1.0.4-r1
	#       - gtk-thinice-theme is dup'd in x11-libs/gtk-thinice-theme-1.0.4-r1
	#   (3) Pick out the newest of each given theme.
	#   (4) Remove the temporary directories.
	echo -n "Untarring themes"
	i=0; while read f; do
		mkdir -p .$i
		case `file "${DISTDIR}/$f"` in
			*GNU?tar?archive)
				tar xC .$i -f "${DISTDIR}/$f" || echo $f ;;
			*gzip*)
				tar xzC .$i -f "${DISTDIR}/$f" || echo $f ;;
			*)
				continue ;; # just skip it
		esac
		# Fix broken themes that don't include a toplevel directory
		if [ -d .$i/gtk ]; then
			# Subshell so it's easy to pop out the directory
			( cd .$i; mkdir "${f%%-*}"; mv gtk "${f%%-*}"; )
		fi
		echo -n .
		: $((i++))
	done < listing
	echo
	ls -dt .[0-9]*/* | while read f; do
		case "$f" in
			*/ThinIce*) continue ;;
			*/Xenophilia-*) continue ;;
			*/gtk-thinice-theme*) continue ;;
		esac
		[ -d "${f#*/}" ] || mv -v "$f" "${f#*/}"
	done
	rm -rf .[0-9]*
}

src_compile() {
	for d in *; do
		[ -f "$d/configure" ] || continue
		# Subshell so it's easy to pop out the directory
		( cd "$d"
		  ./configure \
			--prefix=/usr \
			--infodir=/usr/share/info \
			--mandir=/usr/share/man
		  make || die "Failure building $d"
		)
	done
}

src_install () {
	mkdir -p ${D}/usr/share/themes
	ls -rdt * | while read d; do
		if [ -f "$d/Makefile" ]; then
			# Subshell so it's easy to pop out the directory
			( cd "$d"
			  make install DESTDIR=${D} || \
				make install \
					prefix=${D}/usr \
					mandir=${D}/usr/share/mandir \
					infodir=${D}/usr/share/info || \
						die "Failure installing $d"
			)
		else
			# Don't use doins, etc because they don't handle names
			# with embedded spaces.
			mv -v "$d" ${D}/usr/share/themes
			chmod -R 644 ${D}/usr/share/themes/"$d"
			chown -R root.root ${D}/usr/share/themes/"$d"
		fi
	done
	# Make sure directories have executable permission
	find ${D}/usr/share/themes -type d | while read d; do
		chmod +x "$d"
	done
}
