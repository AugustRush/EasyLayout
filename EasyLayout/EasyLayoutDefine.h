//
//  EasyLayoutDefine.h
//  EasyLayoutDemo
//
//  Created by AugustRush on 1/21/16.
//  Copyright © 2016 AugustRush. All rights reserved.
//

#ifndef EasyLayoutDefine_h
#define EasyLayoutDefine_h

NS_INLINE __attribute__((overloadable)) NSLayoutConstraint *
EL_Layout(ELLayoutConstraintModel *constraint1, ELLayoutConstraintModel *constraint2,
          NSLayoutRelation relation, CGFloat multiplier, CGFloat margin,
          BOOL active) {
  NSLayoutConstraint *constraint =
      [NSLayoutConstraint constraintWithItem:constraint1.view
                                   attribute:constraint1.attribute
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:constraint2.view
                                   attribute:constraint2.attribute
                                  multiplier:multiplier
                                    constant:margin];

  [constraint setActive:active];
  return constraint;
}

NS_INLINE __attribute__((overloadable)) NSLayoutConstraint *
EL_Layout(ELLayoutConstraintModel *constraint1, ELLayoutConstraintModel *constraint2,
          NSLayoutRelation relation, CGFloat multiplier, CGFloat margin) {
  return EL_Layout(constraint1, constraint2, relation, multiplier, margin, YES);
}

// equal relation
NS_INLINE __attribute__((overloadable)) NSLayoutConstraint *
EL_LayoutEqual(ELLayoutConstraintModel *constraint1, ELLayoutConstraintModel *constraint2,
               CGFloat multiplier, CGFloat margin) {
  return EL_Layout(constraint1, constraint2, NSLayoutRelationEqual, multiplier,
                   margin);
}

NS_INLINE __attribute__((overloadable)) NSLayoutConstraint *
EL_LayoutEqual(ELLayoutConstraintModel *constraint1, ELLayoutConstraintModel *constraint2,
               CGFloat margin) {
  return EL_LayoutEqual(constraint1, constraint2, 1, margin);
}

NS_INLINE __attribute__((overloadable)) NSLayoutConstraint *
EL_LayoutEqual(ELLayoutConstraintModel *constraint1, ELLayoutConstraintModel *constraint2) {
  return EL_LayoutEqual(constraint1, constraint2, 0);
}
// greater than or equal relation
NS_INLINE __attribute__((overloadable)) NSLayoutConstraint *
EL_LayoutGreater(ELLayoutConstraintModel *constraint1, ELLayoutConstraintModel *constraint2,
                 CGFloat multiplier, CGFloat margin) {
  return EL_Layout(constraint1, constraint2, NSLayoutRelationGreaterThanOrEqual,
                   multiplier, margin);
}

NS_INLINE __attribute__((overloadable)) NSLayoutConstraint *
EL_LayoutGreater(ELLayoutConstraintModel *constraint1, ELLayoutConstraintModel *constraint2,
                 CGFloat margin) {
  return EL_LayoutEqual(constraint1, constraint2, 1, margin);
}

NS_INLINE __attribute__((overloadable)) NSLayoutConstraint *
EL_LayoutGreater(ELLayoutConstraintModel *constraint1,
                 ELLayoutConstraintModel *constraint2) {
  return EL_LayoutEqual(constraint1, constraint2, 0);
}
// less than or equal relation
NS_INLINE __attribute__((overloadable)) NSLayoutConstraint *
EL_LayoutLess(ELLayoutConstraintModel *constraint1, ELLayoutConstraintModel *constraint2,
              CGFloat multiplier, CGFloat margin) {
  return EL_Layout(constraint1, constraint2, NSLayoutRelationLessThanOrEqual,
                   multiplier, margin);
}

NS_INLINE __attribute__((overloadable)) NSLayoutConstraint *
EL_LayoutLess(ELLayoutConstraintModel *constraint1, ELLayoutConstraintModel *constraint2,
              CGFloat margin) {
  return EL_LayoutEqual(constraint1, constraint2, 1, margin);
}

NS_INLINE __attribute__((overloadable)) NSLayoutConstraint *
EL_LayoutLess(ELLayoutConstraintModel *constraint1, ELLayoutConstraintModel *constraint2) {
  return EL_LayoutEqual(constraint1, constraint2, 0);
}

#endif /* EasyLayoutDefine_h */
