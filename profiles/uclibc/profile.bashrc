# Copyright 2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/profiles/uclibc/profile.bashrc,v 1.2 2005/02/13 20:53:26 solar Exp $

# file - /etc/portage/package.cflags
# This gives us per pkg cflags and is auto expaned into the cxxflags.
#
# We can take individual category names, or we can take individual 
# ebuild names but >= = <= syntax not supported.
#
# FEATURES="distclean"
# This feature removes unneeded SRC_URI distfiles in the postinst ebuild phase.
# This is useful for use with ramfs/tmpfs and small media such as USB sticks.
#

eecho() {
	[ "$NOCOLOR" = "false" ] && echo -ne '\e[1;34m>\e[1;36m>\e[1;35m>\e[0m ' || echo -n ">>> "
	echo "$*"
}

package-distdir-clean() {
	local a x
	for a in ${FEATURES} ; do 
		if [ "$a" = "distclean" ]; then
			for x in ${SRC_URI}; do
			x=$(basename $x)
				if [[ -f $DISTDIR/$x ]]; then
					size="$(ls -lh ${DISTDIR}/${x} | awk '{print $5}')"
					eecho "All done with ${x} Removing it to save ${size}"
					rm ${DISTDIR}/${x}
				fi
			done
		fi
	done
}

#append-cflags() {
#	export CFLAGS="${CFLAGS} $*"
#	export CXXFLAGS="${CXXFLAGS} $*"
#	return 0
#}
#
#package-cflags() {
#	local target flags flag i;
#
#	# bail if file does not exist or is not readable.
#	[ -r ${ROOT}/etc/portage/package.cflags ] || return 0
#
#	# need bash >= 3
#	if [ "${BASH_VERSINFO[0]}" -le 2 ]; then
#		eecho "Need bash3 for this bashrc script to work"
#		return 0
#	fi
#
#	while read -a target; do
#		if [[ ${target[@]%%#*} ]]; then
#
#			# valid syntax no >=<! operators
#			# category CFLAGS
#			# category/package-name CFLAGS
#			if [[ ${target%%#*} && ${target%% *} =~ "^(${CATEGORY}|${CATEGORY}/${PN})\>" ]]; then
#				skip=0
#				if [[ ${target} != ${CATEGORY} ]] ; then
#					if [[ ${target} != ${CATEGORY}/${PN} ]] ; then
#						skip=1
#					fi
#				fi
#				if [ "${skip}" == 0 ] ; then
#					flags=(${target[@]:1})
#					if [[ ${flags[@]} =~ 'CFLAGS' ]]; then
#						for (( i = 0; i < ${#flags[@]}; i++ )); do
#							if [[ ${flags[$i]} =~ 'CFLAGS' ]]; then
#								appened-cflags $(eval echo "${flags[$i]}")
#								unset flags[$i]
#							fi
#						done
#					fi
#					for flag in ${flags[@]}; do
#						if [[ ${CFLAGS} =~ ${flag} ]]; then
#							continue 1
#						else
#							append-cflags "${flag}"
#						fi
#					done
#					export -n C{,XX}FLAGS
#				fi
#			fi
#		fi
#	done < ${ROOT}/etc/portage/package.cflags
#}

if [ "$EBUILD_PHASE" = "/usr/lib/portage/bin/ebuild.sh" -o "$EBUILD_PHASE" = "/usr/lib/portage/bin/ebuild-daemon.sh" -o "$EBUILD_PHASE" = "bash" ]; then
	PATH="/sbin:/usr/sbin:/usr/lib/portage/bin:/bin:/usr/bin:${ROOTPATH}"
	case "$EBUILD_PHASE"  in
		# try to stay quiet in depend.
		depend) : ;;
		prerm|postrm|clean) : ;;
		setup|unpack|postinst|compile|*)
#			package-cflags
			[ "$EBUILD_PHASE" = "postinst" ] && package-distdir-clean
		;;
	esac
else
	echo "This bashrc does not know anything about $EBUILD_PHASE"
fi
